class User < ApplicationRecord
  has_secure_password
  before_validation :downcase_email

  has_many :admins, dependent: :destroy
  has_many :weddings, through: :admins
  has_many :notes, dependent: :nullify

  validates :first_name, presence: true
  validates :last_name, presence: true

  attr_accessor :wedding_admin

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false},
            format: VALID_EMAIL_REGEX

  private

  def downcase_email
    self.email.downcase! if email.present?
  end

end
