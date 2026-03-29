class AddDescriptionV2ToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :description_v2, :text
  end
end
