module ApplicationHelper
  include Pagy::Frontend

  def color_of_answer answer, lesson_answer
    if answer.correct?
      Settings.lessons.correct_answer
    elsif answer.id == lesson_answer.word_answer_id
      Settings.lessons.incorrect_answer
    else
      Settings.lessons.none
    end
  end

  def check_box_of answer, lesson_answer
    if answer.id == lesson_answer.word_answer_id
      Settings.lessons.check_square
    else
      Settings.lessons.square
    end
  end

end
