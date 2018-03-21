class Transportation < ApplicationRecord
  belongs_to :participation
  delegate :trip, to: :participation
end
