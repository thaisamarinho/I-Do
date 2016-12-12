class Service < ApplicationRecord
  belongs_to :wedding

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :notes, dependent: :destroy

  scope :display_chosen, ->(wedding) {
    where(chosen: true, wedding_id: wedding).order(:vendor)
  }

  def self.total_price
    where(chosen: true).map(&:price).sum
  end

  def status
    budget - price
  end

  def status_display_color
    if status >= 0
      'color: green;'
    else
      'color: red;'
    end
  end
end
