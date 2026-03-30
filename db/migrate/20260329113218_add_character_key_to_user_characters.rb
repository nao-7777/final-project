class AddCharacterKeyToUserCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :user_characters, :character_key, :string
  end
end
