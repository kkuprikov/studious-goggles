# frozen_string_literal: true

module Wps
  module Actions
    module Shifts
      class Index < Wps::Action
        def handle(*, response)
          response.format = :json
          response.body = self.class.name
        end
      end
    end
  end
end
