# frozen_string_literal: true

module Wps
  class Settings < Hanami::Settings
    setting :database_url, constructor: Types::String
  end
end
