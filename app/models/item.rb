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
end
