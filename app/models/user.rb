class User < ApplicationRecord

  enum areas: {
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }
  enum occupations: {
    クリエイティブ:1,コンピューター:2,出版:3,放送:4,流通:5,金融:6,
    医療・福祉:7,教育・語学:8,国家・自治体:9,旅行関係:10,料理関係:11,動物・自然:12,
    オフィス:13,サービス:14,エンターテインメント:15,美容・ファッション:16,建築・インテリア:17,
    モノづくり:18,交通機関:19,冠婚葬祭:20,自由業:21,学生:22,その他:23
  }

  # validation section
  validates       :name, presence: true,
                      format: {
                        with: /\A[A-Za-z][A-Za-z0-9]*\z/,
                        allow_blank: false,
                        message: :invalid_user_name
                      },
                      length: { minimum: 2,maximum: 20, allow_blank: false},
                      uniqueness: { case_sensitive: true }
  validates       :introduction, length: { minimum: 2, maximum: 400, allow_blank: true }
  validates       :voice, length: { maximum: 25, allow_blank: true }
  validates       :email, email: { allow_blank: false, message: :invalid_user_email },
                  uniqueness: { case_sensitive: true }
  validates       :gender, :birthday, presence: true
  #validates       :area, presence: true
  validates       :area, :occupation, presence: true

  # Password validation
  has_secure_password
  attr_accessor   :current_password
  validates       :password, presence: { if: :current_password }

  validate  if: :new_profile_picture do
    if new_profile_picture.respond_to?(:content_type)
      unless new_profile_picture.content_type.in?(ALLOWED_CONTENT_TYPES)
        errors.add(:new_profile_picture, :invalid_image_type)
      end
    else
      errors.add(:new_profile_picture, :invalid)
    end
  end

  # Blog & Likes
  has_many         :blogs,       dependent: :destroy
  has_many         :likes,       dependent: :destroy
  has_many         :liked_blogs, through: :likes, source: :blog

  # Follow & Follower relationship
  has_many         :active_relationships,  class_name: "Relationship",
                      foreign_key: "follower_id", dependent: :destroy
  has_many         :passive_relationships, class_name: "Relationship",
                      foreign_key: "followed_id", dependent: :destroy
  has_many         :following, through: :active_relationships,  source: :followed
  has_many         :followers, through: :passive_relationships, source: :follower

  # Attach profile picture
  has_one_attached :profile_picture
  attribute        :new_profile_picture
  attribute        :remove_profile_picture, :boolean
  scope            :fetch_users, ->(user) { where("gender <> ?", user.gender)}

  # ChatRooms
  has_many         :messages, dependent: :destroy

  before_save do
    if new_profile_picture
      self.profile_picture = new_profile_picture
    else
      self.profile_picture.purge if remove_profile_picture
    end
  end

  # To judge whether one user can vote a like
  def votable_for?(blog)
    !likes.exists?(blog_id: blog.id)
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollow the user
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # If logined user was following, return true
  def following?(other_user)
    following.include?(other_user)
  end

  def matched_users(user)
    followers.find_all {|follower| user.following?(follower) }
  end

  # Method of searching users
  def self.search(query)
    rel = order("id")
    if query.present?
      rel = rel.where("name LIKE ? OR voice LIKE ?",
        "%#{query}%", "%#{query}%")
    end
    return rel
  end
end
