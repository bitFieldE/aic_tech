class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, null: false         # outer key
      t.references :blog, null: false         # outer key

      t.timestamps null: false
    end
  end
end
