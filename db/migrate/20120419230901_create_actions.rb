class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer   :task_id,             null: false
      t.string    :channel,             null: false
      t.string    :action,              null: false
      t.text      :parameters
      t.text      :extra_data
      t.boolean   :active,              null: false, default: true

      t.timestamps
    end
    
    add_index :actions, :task_id
    add_index :actions, :active
    add_index :actions, [:channel, :action]
  end
end
