# frozen_string_literal: true
module Main
  module Actions
    module Shifts
      class Create < Action
        include Deps['transactions.create_shift', 'settings']
        
        params do
          required(:shift).hash do
            required(:worker_id).filled(:int?)
            # TODO: use a better validation approach with Date.parse
            required(:day).filled(:str?, format?: /\d{4}-\d{2}-\d{2}/)
            optional(:interval).filled(:int?)
          end
        end
        
        def handle(request, response) 
          halt 422, {errors: request.params.errors}.to_json unless request.params.valid?
          
          if request.params[:shift][:interval].to_i >= settings.daily_shift_limit
            halt 422, {errors: {interval: "Can not exceed #{settings.daily_shift_limit - 1}"}}
          end

          result = create_shift.call(request.params[:shift])
          if result.success?
            response.status = 201
            response.body = result.value!
          else
            response.status = 400
            response.body = {error: result.failure}.to_json
          end
        end
      end
    end
  end
end
