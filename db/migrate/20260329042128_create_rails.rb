class CreateRails < ActiveRecord::Migration[7.0]
  def change
    create_table :rails do |t|
      t.string :g
      t.string :model
      t.string :UserCharacter
      t.references :user, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.boolean :evolved

      t.timestamps
    end
  end
end
