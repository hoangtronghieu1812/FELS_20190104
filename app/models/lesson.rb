class Lesson < ApplicationRecord
  include PublicActivity::Common
  belongs_to :course
  belongs_to :user
  has_many :lesson_answers, dependent: :destroy
  has_many :word_answers, through: :lesson_answers
end
