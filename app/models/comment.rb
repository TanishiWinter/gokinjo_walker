class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post_image

  validates :comment, length: {minimum: 1} #, { message: "は必須です" }

end
