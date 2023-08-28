class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post_image

  validates :comment,presence: { message: "は必須です" }

end
