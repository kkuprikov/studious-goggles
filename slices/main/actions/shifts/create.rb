# frozen_string_literal: true
module Main
  module Actions
    module Shifts
      class Create < Action
        include Deps['repositories.workers', 'repositories.shifts']
        SHIFTS_DAILY_LIMIT = 3

        
        params do
          required(:shift).hash do
            required(:worker_id).filled(:int?)
            # TODO: use a better validation approach with Date.parse
            required(:day).filled(:str?, format?: /\d{4}-\d{2}-\d{2}/)
            optional(:interval).filled(:int?, included_in?: 0...SHIFTS_DAILY_LIMIT)
          end
        end
        
        def handle(request, response)
          response.format = :json
          response.status = 400
          
          if !request.params.valid? || !workers.find(request.params[:shift][:worker_id])
            response.body = {error: "Invalid params"}.to_json
            return
          end

          interval, error = valid_interval(request.params[:shift])
          if interval
            response.status = :created
            shift = shifts.create(**request.params[:shift], interval: interval)
            response.body = Serializers::Shift.new(shift).to_json
          else
            response.body = error.to_json
          end
        end

        private

        def valid_interval(params)
          scheduled_shifts = shifts.filter(day: params[:day]).to_a
          
          if scheduled_shifts.size == SHIFTS_DAILY_LIMIT
            return [nil, {
              error: 'The date is fully booked', 
              shifts: Serializers::Shift.new(scheduled_shifts).serialize
            }]
          end
          
          %i[interval worker_id].each do |param|
            existing_shift = scheduled_shifts.find do |shift| 
              shift.public_send(param) == params[param]
            end
          
            if existing_shift
              return [nil, {
                error: "Conflicting #{param}", 
                shifts: Serializers::Shift.new(existing_shift).serialize
              }]
            end
          end
          return [params[:interval] || (scheduled_shifts.last&.interval || -1) + 1, nil]
        end
      end
    end
  end
end
