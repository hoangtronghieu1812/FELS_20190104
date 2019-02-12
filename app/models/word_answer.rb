class WordAnswer < ApplicationRecord
  belongs_to :word
  has_many :lesson_answers
  has_many :lessons, through: :lesson_answers
  scope :get_result_of_lesson, ->lesson_id { WordAnswer
    .includes(:lesson_answers).where(correct: true,
      lesson_answers: {lesson_id: lesson_id}).count }
end
