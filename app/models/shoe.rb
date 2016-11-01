class Shoe < ApplicationRecord
  belongs_to :user

  validates_presence_of :title

  validates :user, presence: true

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images  

  # store :categories
  # has_many :categories

  # has_many :category_types

  # after_initialize :set_shoe_categories
  # after_create :set_shoe_categories

  # scope :confirmed, -> {where(confirmed: true)}

  # scope :unconfirmed, -> {where(confirmed: false)}

  # def set_shoe_categories

  #   self.category_types << CategoryType.all

  # end
end