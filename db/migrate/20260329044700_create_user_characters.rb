class CreateUserCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :user_characters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.boolean :evolved

      t.timestamps
    end
  end
end
