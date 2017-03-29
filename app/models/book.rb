class Book < ApplicationRecord
  belongs_to :user
  belongs_to :type, counter_cache: true
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user


  validates :name, :publication, presence: true
  validates :cover, presence: true, on: :create


  mount_uploader :cover, CoverUploader
  has_and_belongs_to_many :posts

  after_destroy :destroy_posts


  def followedBy?(user)
    #
    subscriptions.where(user_id: user.id).count > 0 if user.respond_to? :id
  end

  private

  def destroy_posts
    Post.find_by_sql('SELECT * FROM posts LEFT JOIN books_posts ON books_posts.post_id = posts.id WHERE books_posts.post_id IS NULL').each do |post|
      post.destroy
    end
  end

end
