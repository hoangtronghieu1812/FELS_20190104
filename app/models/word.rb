class Word < ApplicationRecord
  belongs_to :course
  has_many :word_answers, dependent: :destroy

  scope :with_correct_answer, -> {Word.includes(:word_answers).
    where(word_answers: {correct: 1})}

  def correct_answer
    word_answers.first
  end
end
