class Post < ApplicationRecord

    has_one_attached :profile_image
    belongs_to :member
    has_many :post_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    belongs_to :category
    #has_many :member


  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
end
