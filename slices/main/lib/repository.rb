# auto_register: false
# frozen_string_literal: true

require 'wps/repository'

module Main
  class Repository < Wps::Repository
    struct_namespace Entities
  end
end
