# frozen_string_literal: true

module Main
  module Actions
    module Workers
      class Index < Wps::Action
        include Deps["repositories.workers"]
        
        def handle(*, response)
          response.format = :json
          response.body = Serializers::Worker.new(workers.all.to_a).serialize
        end
      end
    end
  end
end
