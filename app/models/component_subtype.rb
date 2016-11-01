class ComponentSubtype < ApplicationRecord
  belongs_to :component_type
  has_and_belongs_to_many :components

  validates_presence_of :title
  validates :component_type, presence: true  
end
