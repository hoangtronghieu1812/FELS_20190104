class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :results

      t.timestamps
    end
  end
end
