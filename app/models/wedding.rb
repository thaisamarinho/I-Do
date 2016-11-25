class Wedding < ApplicationRecord
  belongs_to :bride, class_name: 'User', foreign_key: "bride_id"
  belongs_to :groom, class_name: 'User', foreign_key: "groom_id"
  belongs_to :owner, class_name: 'User', foreign_key: "owner_id"
end
