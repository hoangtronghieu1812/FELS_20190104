class Word < ApplicationRecord
  belongs_to :course
  has_many :word_answers, dependent: :destroy
  has_many :lesson_answers, dependent: :destroy

  scope :with_learned, -> user_id {Word.where(id: LessonAnswer
    .includes(:lesson).where(lessons: {user_id: user_id})
      .select('word_id'))}
  scope :with_unlearned, -> user_id {Word.where.not(id: LessonAnswer
    .includes(:lesson).where(lessons: {user_id: user_id})
      .select('word_id'))}
  scope :with_correct_answer, -> {Word.includes(:word_answers)
    .where(word_answers: {correct: 1}).order(:content)}

  def correct_answer
    word_answers.first
  end
end
