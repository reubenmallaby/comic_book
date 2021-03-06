class Book < ActiveRecord::Base
  attr_accessible :available, :description, :name

  validates_presence_of :name

  has_many :chapters
  has_many :comics, :through => :chapters

  scope :available, where(:available => true)


  def increment_counter
    self.update_attribute :comic_count, self.comic_count + 1
  end

end
