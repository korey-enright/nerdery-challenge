class Snack < ApplicationRecord
  has_many   :votes
  belongs_to :user

  validates :name, length: { maximum: 200 }
  validates :purchase_locations, length: { maximum: 50 }
end
