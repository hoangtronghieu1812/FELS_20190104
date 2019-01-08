class Word < ApplicationRecord
  belongs_to :course
  has_many :word_answers, dependent: :destroy
end
