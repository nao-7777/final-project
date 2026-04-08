class Walk < ApplicationRecord
  belongs_to :user
  has_many :missions, dependent: :destroy
end
