class LessonAnswer < ApplicationRecord
  belongs_to :lesson
  belongs_to :word_answer
  belongs_to :word
  scope :get_word_ids_in_lesson, ->lesson_id { LessonAnswer
    .where(lesson_id: lesson_id).pluck(:word_id) }
end
