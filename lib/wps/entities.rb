# auto_register: false
# frozen_string_literal: true

module Wps
  module Entities
  end
end

Dir[File.join(__dir__, 'entities', '*.rb')].each(&method(:require))
