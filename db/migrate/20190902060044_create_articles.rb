class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title, null: false                            # title
      t.text :body, null: false                               # body
      t.datetime :released_at                                 # released date
      t.datetime :expired_at                                  # expiration date
      t.boolean :user_list_only, null: false, default: false  # user list only flag
      t.timestamps
    end
  end
end
