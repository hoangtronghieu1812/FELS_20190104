class LessonAnswer < ApplicationRecord
  belongs_to :lesson
  belongs_to :word_answer

  scope :get_answer, -> user_id {LessonAnswer
    .includes(:lesson,[word_answer: :word])
      .where(lessons: {user_id: user_id})}
end
