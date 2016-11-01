class Opinion < ApplicationRecord
  belongs_to :user
  # belongs_to :producer

  # validates :user_id, presence: true, allow_nil: true
  # validates :user, length: {minimum: 1, allow_nil: true}
  # validates :producer, presence: true
  validates :user_id, presence: true

end
