class Component < ApplicationRecord
  has_and_belongs_to_many :component_types
  has_and_belongs_to_many :component_subtypes

  validates_presence_of :title

  validate do |component|
# http://stackoverflow.com/questions/808547/fully-custom-validation-error-message-with-rails  	
    component.errors.add(:base, "Раздел не может быть пустым") if component.component_types.blank?
  end

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images   

end
