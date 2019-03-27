class Test < ActiveRecord::Migration[5.2]
  def change
    add_index :words, [:content, :course_id], unique: true
  end
end
