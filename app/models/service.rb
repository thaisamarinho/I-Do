class Service < ApplicationRecord

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def self.total_price
    all.map{|p| p.price}.sum
  end

  def status
    budget - price
  end

end
