module Main
  module Repositories
    class Workers < Repository[:workers]
      commands :create, update: :by_pk

      def all
        workers.combine(:shifts)
      end

      def find(id)
        workers.combine(:shifts).by_pk(id).one
      end
    end
  end
end
