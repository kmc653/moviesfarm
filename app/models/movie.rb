class Movie < ActiveRecord::Base
  validates_presence_of :title, :year, :plot
end