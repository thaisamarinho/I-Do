class Wedding < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: "owner_id"

  has_many :guests, dependent: :destroy
  has_many :admins, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :tables, dependent: :destroy

  has_many :users, through: :admins

  mount_uploaders :images, ImageUploader
  attr_accessor :images_cache

  validates :name, presence: true
  validates :budget, presence: true


  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end

end
