class Course < ApplicationRecord
  searchkick  highlight: [:name, :description], word_start: [:name, :description]
  has_many :words
  has_many :lessons, dependent: :destroy

  scope :with_users, -> {Course.includes(:lessons).group(:course_id)
    .count('user_id')}
  scope :with_lessons, -> {Course.includes :lessons}
  delegate :size, to: :words, prefix: true

  def search_data
    {
      name: name,
      description: description
    }
  end
end
