class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.date :publication
      t.references :user, foreign_key: true
      t.references :type, foreign_key: true

      t.timestamps
    end
  end
end
