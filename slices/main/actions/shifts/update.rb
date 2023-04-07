# frozen_string_literal: true

module Main
  module Actions
    module Shifts
      class Update < Wps::Action
        def handle(*, response)
          response.format = :json
          response.body = self.class.name
        end
      end
    end
  end
end
