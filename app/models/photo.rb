class Photo < Asset
  has_many :table_specifications
  accepts_nested_attributes_for :table_specifications

end
