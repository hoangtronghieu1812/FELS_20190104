class AddWordToLessonAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :lesson_answers, :word_id, :integer
  end
end
