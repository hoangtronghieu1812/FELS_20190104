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

  def menu_for_word(parent, abstract_model = nil, object = nil,
    only_icon = false)
    actions = actions(parent, abstract_model, object)
      .select{|a| a.http_methods.include?(:get)}
    wording = wording_for(:menu, :new)
      %(
        <li class="icon new_collection_link">
          <a class="pjax" href="http://localhost:3000/admin/word/new_word">
            <i class="icon-plus"></i>
            <span#{only_icon ? " style='display:none'" : ''}>#{wording}</span>
          </a>
        </li>
        <li class="icon import_collection_link">
          <a class="pjax" href="http://localhost:3000/admin/word/import_word">
            <i class="icon-file"></i>
            <span#{only_icon ? " style='display:none'" : ''}>Import words</span>
          </a>
        </li>
      ).html_safe
  end
end
