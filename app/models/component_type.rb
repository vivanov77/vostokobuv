class ComponentType < ApplicationRecord
  has_many :component_category_types
  has_many :component_subtypes
  has_and_belongs_to_many :components
  
  validates_presence_of :title
  validates_associated :component_category_types

  has_one :image, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :image   
end
