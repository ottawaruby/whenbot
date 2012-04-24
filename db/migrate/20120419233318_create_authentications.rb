class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :channel,    null: false
      t.text   :parameters

      t.timestamps
    end
    
    add_index :authentications, :channel, unique: true
  end
end
