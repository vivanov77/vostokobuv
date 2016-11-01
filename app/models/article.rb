class Article < ApplicationRecord
  has_many :images, as: :imageable, dependent: :destroy
end
