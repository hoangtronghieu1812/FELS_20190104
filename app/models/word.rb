class Word < ApplicationRecord
  searchkick word_start: [:content], highlight: [:content]
  belongs_to :course
  has_many :word_answers, dependent: :destroy
  has_many :lesson_answers, dependent: :destroy

  scope :with_learned, -> user_id {Word.where(id: LessonAnswer.includes(:lesson)
    .where(lessons: {user_id: user_id})
      .where.not(lesson_answers: {word_answer_id: nil})
        .select('word_id'))}
  scope :with_unlearned, -> user_id {Word.where.not(id: LessonAnswer.includes(:lesson)
      .where(lessons: {user_id: user_id})
        .where.not(lesson_answers: {word_answer_id: nil})
          .select('word_id'))}
  scope :with_correct_answer, -> {Word.includes(:word_answers)
    .where(word_answers: {correct: 1}).order(:content)}
  scope :random_words, -> {order(Arel.sql("RAND()"))
    .limit(Settings.word.number_of_words)}
  scope :with_users, -> {Word.includes(lesson_answers: [:lesson])
    .where.not(lesson_answers: {word_answer_id: nil})
      .group(:word_id).count(:user_id)}

  accepts_nested_attributes_for :word_answers,
    reject_if: lambda { |a| a[:content].blank? },
      allow_destroy: true

  def correct_answer
    word_answers.first
  end

  def search_data
    { content: content }
  end

  class << self

    def import_file file
      spreadsheet = Roo::Spreadsheet.open file
      header = spreadsheet.row(1)
      words = []
      ActiveRecord::Base.transaction do
        (2..spreadsheet.last_row).each do |i|
          row = Hash[[header, spreadsheet.row(i)].transpose]
          attrs_word = Hash.new
          attrs_word["course_id"] = Course.find_by(name: row["course"]).id
          attrs_word["content"] = row["word"]
          word_answers_attributes = []
          row["answers"].split(";").each do |answer|
            answer_attributes = Hash.new
            attrs_answer = answer.split(": ")
            answer_attributes["content"] = attrs_answer[0]
            answer_attributes["correct"] = attrs_answer[1]
            word_answers_attributes << answer_attributes
          end
          attrs_word["word_answers_attributes"] = word_answers_attributes
          word = Word.new attrs_word
          word.save
        end
      end
    end
  end
end
