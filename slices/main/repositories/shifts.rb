module Main
  module Repositories
    class Shifts < Repository[:shifts]
      commands :create, update: :by_pk

      def filter(**params)
        shifts.where(**params).order(:interval)
      end

      def find(id)
        shifts.combine(:worker).by_pk(id).one
      end
    end
  end
end
