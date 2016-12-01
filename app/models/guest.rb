class Guest < ApplicationRecord
  belongs_to :wedding

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :first_name, uniqueness: {scope: :last_name, case_sensitive: false, message: "This guest is already in the list."}
  before_save :capitalize_guest

  def self.total_guests
    where(plus_one: false).all.count +
    (where(plus_one: true).all.count) * 2
  end

  def self.search(search)
    where("first_name ILIKE ? OR last_name ILIKE ?", "%#{search}%", "%#{search}%")
  end

  def self.confirmed_guests
    where(plus_one: false, rsvp: true).all.count +
    (where(plus_one: true, rsvp: true).all.count) * 2
  end


  private

  def full_name
    first_name + " " + last_name
  end

  def capitalize_guest
    self.first_name = first_name.titleize
    self.last_name = last_name.titleize
  end

end
