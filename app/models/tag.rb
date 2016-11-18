class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :services, through: :taggings
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
