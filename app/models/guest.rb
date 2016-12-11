class Guest < ApplicationRecord
  belongs_to :wedding
  belongs_to :table

  validates :name, presence: true, uniqueness: true


  before_save :capitalize_guest

  def self.total_guests
    where(plus_one: false).all.count +
    (where(plus_one: true).all.count) * 2
  end

  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end

  def self.confirmed_guests
    where(plus_one: false, rsvp: true).all.count +
    (where(plus_one: true, rsvp: true).all.count) * 2
  end

  scope :display_guest, -> (wedding) {
    where(rsvp: false, wedding_id: wedding).order(:name)
  }


  private

  def capitalize_guest
    self.name = name.titleize
  end

end
