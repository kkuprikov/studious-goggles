require 'dry-monads'
module Main
  module Transactions
    class CreateShift
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)
      include Deps['repositories.workers', 'repositories.shifts', 'settings']

      def call(args)
        find_worker(args[:worker_id]).bind do
          has_shift(worker_id: args[:worker_id], day: args[:day]).bind do
            available_interval(day: args[:day], requested_interval: args[:interval]).fmap do |interval|
              shift = shifts.create(**args, interval: interval)
              Serializers::Shift.new(shift).to_json
            end
          end
        end
      end

      private

      def find_worker id
        if workers.find(id)
          Success()
        else
          Failure(:worker_not_found)
        end
      end

      def available_interval day:, requested_interval:
        if requested_interval && shifts.filter(day: day, interval: requested_interval).to_a.size.positive?
          return Failure(:interval_booked)
        end

        booked_shifts = shifts.filter(day: day)
        if booked_shifts.to_a.size == settings.daily_shift_limit
          return Failure(:day_fully_booked)
        end

        available_intervals = (0...settings.daily_shift_limit).to_a - booked_shifts.pluck(:interval)

        Success(requested_interval || available_intervals.first)
      end

      def has_shift worker_id:, day:
        if !shifts.filter(day: day, worker_id: worker_id).to_a.empty?
          Failure(:has_shift)
        else
          Success()
        end
      end

    end
  end
end