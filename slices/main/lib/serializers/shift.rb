module Main
  module Serializers
    class Shift < Serializer
      root_key :shift

      attributes :id, :worker_id, :day, :interval
    end
  end
end