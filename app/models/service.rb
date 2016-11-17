class Service < ApplicationRecord

  def self.total_price
    all.map{|p| p.price}.sum
  end

  def status
    budget - price
  end
  
end
