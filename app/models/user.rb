class User < ApplicationRecord
  has_secure_password
  before_validation :downcase_email

  has_many :weddings, inverse_of: :owner, foreign_key: :owner_id

  has_many :brides_for, inverse_of: :bride,
                        class_name: 'Wedding',
                        foreign_key: :bride_id

  has_many :grooms_for, inverse_of: :groom,
                        class_name: 'Wedding',
                        foreign_key: :groom_id

  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false},
            format: VALID_EMAIL_REGEX

  private

  def downcase_email
    self.email.downcase! if email.present?
  end

end
