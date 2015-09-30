class Project < ActiveRecord::Base
  has_many :specifications, dependent: :destroy
  has_many :statuses
  belongs_to :user
  belongs_to :client
  belongs_to :city
  belongs_to :style

  accepts_nested_attributes_for :specifications
  accepts_nested_attributes_for :statuses

  validates :object_name, presence: true
  # validates :client, presence: true

  def self.find_table_specifications(ids)
 	  table_specifications = TableSpecification.where(specification: ids).all
  end

  def self.find_statuses(ids)
    statuses = Status.where(project: ids).all
  end
  
  def status
    statuses.last.name
  end

  def status_description
    statuses.last.description
  end

end
