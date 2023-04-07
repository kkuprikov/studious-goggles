# frozen_string_literal: true

require "hanami"

module Wps
  class App < Hanami::App
    config.actions.format :json
    config.middleware.use :body_parser, :json
  end
end
