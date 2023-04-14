class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   has_one_attached :profile_image
   has_many :post_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy
   has_many :posts, dependent: :destroy

   # フォロー機能
   has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
   has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

   has_many :followings, through: :relationships, source: :followed
   has_many :followers, through: :reverse_of_relationships, source: :follower

     def follow(member_id)
       relationships.create(followed_id: member_id)
     end

     def unfollow(member_id)
       relationships.find_by(followed_id: member_id).destroy
     end

     def following?(member)
       followings.include?(member)
     end

   # プロフィール画像
   def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
     profile_image.variant(resize_to_limit: [width, height]).processed
   end
   #検索機能
    def self.search(search)
    if search != ""
      Member.where(['name LIKE(?) OR introduction LIKE(?) OR playstyle LIKE(?)',"%#{search}%","%#{search}%","%#{search}%"])
    else
     Member.all
    end
  end
end