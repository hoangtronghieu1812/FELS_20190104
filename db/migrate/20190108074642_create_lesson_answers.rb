class CreateLessonAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :lesson_answers do |t|
      t.integer :word_answer_id
      t.integer :lesson_id

      t.timestamps
    end
  end
end
