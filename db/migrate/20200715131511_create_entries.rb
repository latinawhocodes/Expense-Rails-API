class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.integer :amount
      t.string :description
      t.string :date

      t.belongs_to :expense, null: false, foreign_key: true
      t.timestamps
    end
  end
end
