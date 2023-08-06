class PostImage < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :read_counts, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
