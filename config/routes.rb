# frozen_string_literal: true

module Wps
  class Routes < Hanami::Routes
    slice :main, at: '/' do
      get "/workers", to: "workers.index"
      post "/workers", to: "workers.create"
      get "/workers/:id", to: "workers.show"
      put "/workers/:id", to: "workers.update"
      
      get "/shifts", to: "shifts.index"
      post "/shifts", to: "shifts.create"
      put "/shifts/:id", to: "shifts.update"
    end
  end
end
