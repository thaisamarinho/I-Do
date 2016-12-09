class Service < ApplicationRecord
  belongs_to :wedding

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :notes, dependent: :destroy

  scope :display_chosen, -> (wedding) {
    where(chosen: true, wedding_id: wedding).order(:vendor)
  }

  def self.total_price
    where(chosen: true).map{|p| p.price}.sum
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
