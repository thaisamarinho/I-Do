class Table < ApplicationRecord
  belongs_to :wedding
  has_many :guests, dependent: :nullify
end
