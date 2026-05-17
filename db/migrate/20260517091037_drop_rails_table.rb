class DropRailsTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :rails if table_exists?(:rails)
  end

  def down
    # 巻き戻し（復活）はしないので空っぽでOK
  end
end