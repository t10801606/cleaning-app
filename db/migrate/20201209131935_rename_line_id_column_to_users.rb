class RenameLineIdColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :line_id, :line_token
  end
end
