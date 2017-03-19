class CreateTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :types do |t|
      t.string :name
      t.string :slug
      t.integer :books_count

      t.timestamps
    end
  end
end
