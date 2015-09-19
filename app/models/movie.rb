class Movie < ActiveRecord::Base
  validates_presence_of :title, :year, :plot
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :reviews

  has_attached_file :image, styles: { medium: "400x600#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end