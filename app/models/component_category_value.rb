class ComponentCategoryValue < ApplicationRecord
  belongs_to :component_category_type

  validates_presence_of :title
  validates :component_category_type, presence: true
end
