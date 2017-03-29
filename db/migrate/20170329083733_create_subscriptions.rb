class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_join_table :books, :users, table_name: 'subscriptions' do |t|
      t.index [:book_id, :user_id]
      t.index [:user_id, :book_id]
    end
  end
end

