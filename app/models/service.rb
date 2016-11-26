class Service < ApplicationRecord

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :notes, dependent: :destroy

  def self.total_price
    all.map{|p| p.price}.sum
  end

  def status
    budget - price
  end

end
