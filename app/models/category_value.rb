class CategoryValue < ApplicationRecord
  # belongs_to :category, optional: true
  # http://blog.bigbinary.com/2016/02/15/rails-5-makes-belong-to-association-required-by-default.html
  belongs_to :category_type

  validates_presence_of :title

  validates :category_type, presence: true

  has_one :image, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :image  
  
end