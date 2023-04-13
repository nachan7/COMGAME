class Post < ApplicationRecord

    has_one_attached :profile_image
    belongs_to :member
    has_many :post_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    belongs_to :category

#気になる機能
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

#検索機能
   def self.search(search)
    if search != ""
      Post.where(['title LIKE(?) OR body LIKE(?)',"%#{search}%","%#{search}%"])
    else
      Post.all
    end
  end
end