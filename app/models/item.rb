class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :name, presence: true
  validates :explanation, presence: true
  validates :without_tax_price, presence: true

  def bookmarked_by?(customer)
    bookmarks.where(customer_id: customer).exists?
  end

  def add_tax_sales_price
   (self.without_tax_price * 1.10).round
  end

  def get_image
    (image.attached?) ? image : 'no-image.jpg'
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "explanation", "genre_id", "id", "is_sale", "name", "updated_at", "without_tax_price"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["bookmarks", "cart_items", "genre", "image_attachment", "image_blob", "order_items", "reviews"]
  end
end
