class CreateTriggers < ActiveRecord::Migration
  def change
    create_table :triggers do |t|
      t.integer  :task_id,             null: false
      t.string   :channel,             null: false
      t.string   :trigger,             null: false
      t.boolean  :polling_trigger,     null: false, default: false
      t.text     :parameters
      t.text     :match_data
      t.datetime :last_matched
      t.text     :extra_data
      t.string   :webhook_uid
      t.boolean  :active,              null: false, default: true      

      t.timestamps
    end

    add_index :triggers, :task_id
    add_index :triggers, :polling_trigger
    add_index :triggers, :active
    add_index :triggers, [:active, :polling_trigger]
    add_index :triggers, [:channel, :trigger]
  end
end
