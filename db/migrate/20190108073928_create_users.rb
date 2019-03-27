class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.integer :age
      t.string :job
      t.timestamps
    end
    add_index :users, [:name, :age], unique: true
  end
end
