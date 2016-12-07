class Admin < ApplicationRecord
  belongs_to :wedding
  belongs_to :user
end
