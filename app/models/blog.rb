class Blog < ApplicationRecord
  belongs_to        :author, class_name: "User", foreign_key: "user_id"
  has_many          :likes, dependent: :destroy
  has_many          :liked_users, through: :likes, source: :user
  has_many_attached :blog_images
  attribute         :new_blog_images
  
  # follower list only
  STATUS_ARRAY = %w(draft user_list_only public)

  validates :title, presence: true, length: { maximum: 40 }
  validates :body, :posted_at, presence: true
  validates :body, length: { maximum: 3000 }
  validates :status, inclusion: { in: STATUS_ARRAY }
  validate  :check_attached_images

  # method of searching blogs
  def self.search(query)
    rel = order("id")
    if query.present?
      rel = rel.where("title LIKE ? OR body LIKE ?",
        "%#{query}%", "%#{query}%")
    end
    return rel
  end

  # check blog_images blank
  MAX_PICTURE_RESISTER = 5
  before_save do
    if new_blog_images && self.blog_images.count < MAX_PICTURE_RESISTER
      new_blog_images.each do |new_blog_image|
        self.blog_images = new_blog_image
      end
    end
  end

  # validation method
  def check_attached_images
    if new_blog_images.present?
      errors.add(:new_blog_images, :invalid_blog_images_count) if (new_blog_images.count + self.blog_images.count) > MAX_PICTURE_RESISTER
      new_blog_images.each do |new_blog_image|
        if new_blog_image.respond_to?(:content_type)
          unless new_blog_image.content_type.in?(ALLOWED_CONTENT_TYPES)
            errors.add(:new_blog_images, :invalid_image_type)
          end
        else
          errors.add(:new_blog_images, :invalid)
        end
      end
    end
  end

  # fetch articles
  scope :common, -> { where(status: "public") }
  scope :published, -> { where("status <> ?", "draft")}
  scope :full, ->(user) {
    where("status <> ? OR user_id = ?", "draft", user.id) }
  scope :readable_for, ->(user) { user ? full(user) : common }

  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.blog.status_#{status}")
    end

    def status_options
      STATUS_ARRAY.map { |status| [status_text(status), status]}
    end
  end
end
