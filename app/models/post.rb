class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :content             #without this it was calling it protected
  validates :user_id, :presence => true
  validates :content, :presence => true

end
