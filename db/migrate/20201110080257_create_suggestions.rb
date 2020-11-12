class CreateSuggestions < ActiveRecord::Migration[6.0]
  def change
    create_table :suggestions do |t|
      t.string :place, null: false
      t.boolean :status, null: false
      t.integer :period_cleaning, null: false
      t.date :last_cleaned_date, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
