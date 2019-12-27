class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.references :user, null: false                     # outer key
      t.string :title, null: false                        # title
      t.text :body, null: false                           # text body
      t.datetime :posted_at, null: false                  # posted at
      t.string :status, null: false, default: "draft"     # status
      t.timestamps null: false
    end
  end
end
