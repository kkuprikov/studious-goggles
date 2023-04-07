Hanami.application.register_provider :serializers do
  start do
    require "alba"

    Alba.backend = :oj
  end
end