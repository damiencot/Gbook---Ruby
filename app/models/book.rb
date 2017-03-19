class Book < ApplicationRecord
  belongs_to :user
  belongs_to :type, counter_cache: true


  validates :name, :publication, presence: true
  validates :avatar_file, presence: true, on: :create


  has_image :avatar



end
