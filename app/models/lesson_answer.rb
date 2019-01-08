class LessonAnswer < ApplicationRecord
  belongs_to :lesson
  belongs_to :word_answer
end
