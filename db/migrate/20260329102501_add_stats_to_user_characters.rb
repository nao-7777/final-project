class AddStatsToUserCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :user_characters, :exp, :integer, default: 0
    add_column :user_characters, :level, :integer, default: 1
  end
end
