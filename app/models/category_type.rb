class CategoryType < ApplicationRecord
  has_many :category_values

  validates :title, presence: true, uniqueness: true
  
  # belongs_to :category, dependent: :destroy
  # belongs_to :shoe

  # def category_value_id(c_id)
  #   update_attribute(:category_value, CategoryValue.find(c_id))
  # end  

  # def category_value_id
  # 	# category_value.id
  # end	

  # def category_value_id=(value)
  #   self.category_value = CategoryValue.find(value)
  # end

  # def category_value_id
  #   # category_value ? category_value_id : nil
  # end

  # before_destroy :check_shoes

  # def check_shoes

  #   p "check_shoes"

  # end

end
