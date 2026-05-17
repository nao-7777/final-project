class DeleteRailsTableReal < ActiveRecord::Migration[7.0]
  def change
    # すでにマイグレーションの履歴がどうなっていても、強制的にrailsテーブルをドロップします
    drop_table :rails if table_exists?(:rails)
  end
end
