class CreateDesks < ActiveRecord::Migration[6.0]
  def change
    create_table :desks do |t|
      t.string  :title,              null: false
      t.text    :concept
      t.references :user,            null: false, foreign_key: true
      t.timestamps
    end
  end
end
