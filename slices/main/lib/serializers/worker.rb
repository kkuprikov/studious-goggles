module Main
  module Serializers
    class Worker < Serializer
      root_key :worker

      attributes :id, :name

      many :shifts, resource: Shift
    end
  end
end
