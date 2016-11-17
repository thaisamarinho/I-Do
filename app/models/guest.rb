class Guest < ApplicationRecord

  scope :confirmed_guests, lambda { where(rsvp: :true) }

  validates :first_name, uniqueness: {scope: :last_name, case_sensitive: false, message: "This guest is already in the list"}

  def self.total_guests
    all.count
  end


  def full_name
    first_name + " " + last_name
  end

end
