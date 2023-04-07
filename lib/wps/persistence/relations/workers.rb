# frozen_string_literal: true

module Wps
  module Persistence
    module Relations
      class Workers < ROM::Relation[:sql]
        schema(:workers, infer: true) do
          associations do
            has_many :shifts
          end
        end
      end
    end
  end
end
