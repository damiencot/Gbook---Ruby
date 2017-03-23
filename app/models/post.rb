class Post < ApplicationRecord

  belongs_to :user # Un post appartient à un utilisateur
  has_and_belongs_to_many :books

=begin
  has_image :image, resize: '940x530', formats: {
      thumb: '360x200'
  }
=end

  mount_uploader :image, ImageUploader

  validates :name, :content, presence: true
  validates :image, presence: true, on: :create

end
