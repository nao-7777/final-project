class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.text :description
      t.string :image_v1
      t.string :image_v2
      t.integer :rarity
      t.integer :evolution_level

      t.timestamps
    end
  end
end
