class Gift < ApplicationRecord
  belongs_to :wedding

  mount_uploaders :image, ImageUploader
end
