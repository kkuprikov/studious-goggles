module Main
  module Serializers
    class Worker < Serializer
      root_key :worker

      attributes :id, :name

      # TODO: instead of the conditional, a separate serializer could be used
      many :shifts, resource: Shift, if: ->(worker) { worker.respond_to?(:shifts) }
    end
  end
end
