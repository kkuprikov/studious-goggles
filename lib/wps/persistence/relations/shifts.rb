# frozen_string_literal: true

module Wps
  module Persistence
    module Relations
      class Shifts < ROM::Relation[:sql]
        schema(:shifts, infer: true) do
          associations do
            belongs_to :workers, as: :worker
          end
        end
      end
    end
  end
end
