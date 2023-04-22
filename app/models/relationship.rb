class Relationship < ApplicationRecord
  # フォローした
  belongs_to :follower, class_name: "Member"
  # フォローされた
  belongs_to :followed, class_name: "Member"

end
