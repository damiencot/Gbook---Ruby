class CreateJoinTableBookPost < ActiveRecord::Migration[5.0]
  def change
    create_join_table :books, :posts do |t|
       t.index [:book_id, :post_id]
       t.index [:post_id, :book_id]
    end
  end
end
