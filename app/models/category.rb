class Category < ActiveRecord::Base
  has_many :post
  attr_accessible :name         #without this it was calling it protected
  validates :name, :presence => true
end
