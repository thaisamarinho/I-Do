class Guest < ApplicationRecord
  belongs_to :wedding

  scope :confirmed_guests, lambda { where(rsvp: :true) }


  validates :first_name, uniqueness: {scope: :last_name, case_sensitive: false, message: "This guest is already in the list"}

  def self.total_guests
    all.count
  end

  def self.search(search)
    where("first_name ILIKE ? OR last_name ILIKE ?", "%#{search}%", "%#{search}%")
  end


  def full_name
    first_name + " " + last_name
  end

end
