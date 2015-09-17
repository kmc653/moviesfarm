class Movie < ActiveRecord::Base
  validates_presence_of :title, :year, :plot
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
end