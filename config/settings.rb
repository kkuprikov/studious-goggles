# frozen_string_literal: true

module Wps
  class Settings < Hanami::Settings
    setting :database_url, constructor: Types::String
    setting :daily_shift_limit, constructor: Types::Integer, default: 3
  end
end
