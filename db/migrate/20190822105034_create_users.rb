class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false                            # user name
      t.string :full_name, null: false                       # full name
      t.string :email, null: false                           # email
      t.date :birthday, null: false                          # birthday
      t.string :area, null: false                           # area
      t.string :occupation, null: false                     # occupation
      t.integer :gender, null: false, default: 1             # gender(1: male, 2: female)
      t.text :voice, limit: 25                               # something mumur
      t.text :introduction, limit: 400                       # self introduction
      t.boolean :administrator, null: false, default: false  # administrator flag

      t.timestamps
    end
  end
end
