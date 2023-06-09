class Post < ApplicationRecord

    has_one_attached :profile_image
    belongs_to :member
    has_many :post_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    belongs_to :category

     validates :title, presence: true,length:{maximum:50}
     validates :body, presence: true,length:{maximum:400}


#気になる機能
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

#検索機能
  def self.search(search)
    if search != ""
      if search[:category_id] == ""
        #Post.joins(:category).where("categories.name like ?", "%#{search}%").or(Post.where(['title LIKE(?) OR body LIKE(?)',"%#{search}%","%#{search}%"]))
        Post.where(['title LIKE(?) OR body LIKE(?)',"%#{search[:keyword]}%","%#{search[:keyword]}%"])
      else
        Post.where(category_id: search[:category_id]).where(['title LIKE(?) OR body LIKE(?)',"%#{search[:keyword]}%","%#{search[:keyword]}%"])
      end
    else
      Post.all
    end
  end

end