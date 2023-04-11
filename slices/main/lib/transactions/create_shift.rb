require 'dry-monads'
module Main
  module Transactions
    class CreateShift
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)
      include Deps['repositories.workers', 'repositories.shifts', 'settings']

      def call(args)
        yield find_worker(args[:worker_id])
        yield has_shift(**args.slice(:worker_id, :day))
        interval = yield available_interval(**args.slice(:day, :interval))
        shift = shifts.create(**args, interval: interval)
        Success(Serializers::Shift.new(shift).to_json)
      end

      private

      def find_worker id
        if workers.find(id)
          Success()
        else
          Failure(:worker_not_found)
        end
      end

      def available_interval day:, interval: nil
        booked_shifts = shifts.filter(day: day)

        if interval && booked_shifts.to_a.find{|shift| shift.interval == interval}
          return Failure(:interval_booked)
        end

        if booked_shifts.to_a.size == settings.daily_shift_limit
          return Failure(:day_fully_booked)
        end

        available_intervals = (0...settings.daily_shift_limit).to_a - booked_shifts.pluck(:interval)

        Success(interval || available_intervals.first)
      end

      def has_shift worker_id:, day:
        if !shifts.filter(day: day, worker_id: worker_id).to_a.empty?
          Failure(:worker_has_shift)
        else
          Success()
        end
      end
    end
  end
end