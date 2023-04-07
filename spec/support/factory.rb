require "rom-factory"

Factory = ROM::Factory.configure do |config|
  config.rom = Wps::App.container['persistence.rom']
end

Dir[File.dirname(__FILE__) + '/factories/*.rb'].each { |file| require file }
