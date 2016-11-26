class Note < ApplicationRecord
  belongs_to :service
  belongs_to :user

  validates :body, presence: true

  def self.full_name
    first_name + " " + last_name
  end

end
