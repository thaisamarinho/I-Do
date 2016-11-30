class Service < ApplicationRecord
  belongs_to :wedding

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :notes, dependent: :destroy

  def self.total_price
    all.map{|p| p.price}.sum
  end

  def status
    budget - price
  end

  def status_display_color
    if status >= 0
      return 'color: green;'
    else
      return 'color: red;'
    end
  end

end
