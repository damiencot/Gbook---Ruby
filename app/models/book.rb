class Book < ApplicationRecord
  belongs_to :user
  belongs_to :type, counter_cache: true


  validates :name, :publication, presence: true
  validates :cover, presence: true, on: :create


  # has_image :book
  mount_uploader :cover, CoverUploader
  has_and_belongs_to_many :posts

  after_destroy :destroy_posts


  private

  def destroy_posts
    Post.find_by_sql('SELECT * FROM posts LEFT JOIN books_posts ON books_posts.post_id = posts.id WHERE books_posts.post_id IS NULL').each do |post|
      post.destroy
    end
  end

end
