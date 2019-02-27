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

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object,
      child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields",
      data: {id: id, fields: fields.gsub("\n", "")})
  end
end
