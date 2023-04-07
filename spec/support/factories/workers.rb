require 'faker'

Factory.define(:worker) do |f|
  f.name { Faker::Name.name }
end
