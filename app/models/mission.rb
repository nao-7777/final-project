class Mission < ApplicationRecord
  belongs_to :walk, optional: true
  has_one_attached :image
end
