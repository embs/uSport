class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => "User", :foreign_key => :user_id
  belongs_to :move
  attr_accessible :body

  validates_presence_of :body, :author, :move
end
