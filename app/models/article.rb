class Article < ApplicationRecord
  validates :title, :body, :released_at, presence: true
  validates :title, length: { maximum: 40 }
  validates :body,  length: { maximum: 2000 }

  def no_expiration
    expired_at.nil?
  end

  def no_expiration=(val)
    @no_expiration = val.in?([true, "1"])
  end

  before_validation do
    self.expired_at = nil if @no_expiration
  end

  # method of searching articles
  def self.search(query)
    rel = order("id")
    if query.present?
      rel = rel.where("title LIKE ? OR body LIKE ?",
        "%#{query}%", "%#{query}%")
    end
    return rel
  end

  scope :open_to_the_public, -> { where(user_list_only: false) }

  validate do
    if expired_at && expired_at < released_at
      errors.add(:expired_at, :expired_at_too_old)
    end
  end

  scope :visible, -> do
    now = Time.current

    where("released_at <= ?", now)
      .where("expired_at > ? OR expired_at IS NULL", now)
  end
end
