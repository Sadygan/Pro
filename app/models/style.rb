class Style < ActiveRecord::Base
  has_many :projects
  accepts_nested_attributes_for :projects

  validates :name, presence: true, length: {minimum: 2}

end
