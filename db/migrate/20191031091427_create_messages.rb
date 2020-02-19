class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user, null: false
      t.integer :receiver_id, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
