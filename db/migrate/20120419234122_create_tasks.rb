class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string   :name
      t.datetime :last_executed
      t.boolean  :active,         null: false, default: true
      
      t.timestamps
    end
    
    add_index :tasks, :active
  end
end
