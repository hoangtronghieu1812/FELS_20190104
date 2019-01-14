class Course < ApplicationRecord
  has_many :words
  has_many :lessons, dependent: :destroy

  scope :with_users, -> {Course.includes(:lessons).group(:course_id)
    .count('user_id')}
  delegate :size, to: :words, prefix: true
end
