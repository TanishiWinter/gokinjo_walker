class PostImage < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :read_counts, dependent: :destroy
  validates :title,presence:true
  validates :address,presence:true
  validates :body,presence:true,length:{maximum:200}

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  before_save :convert_coordinates

  private

  def convert_coordinates
    self.latitude = self.latitude.to_f  # 必要に応じて変換処理を追加
    self.longitude = self.longitude.to_f
  end

end
