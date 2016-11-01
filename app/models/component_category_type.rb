class ComponentCategoryType < ApplicationRecord
  has_many :component_category_values
  belongs_to :component_type

  validates_presence_of :title
  validates :component_type, presence: true
end
