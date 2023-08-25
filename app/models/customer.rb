class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookmarks, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  def active_for_authentication?
    super && (is_withdrawal == false)
  end

  def full_name
  first_name + '' + last_name
  end

  def full_name_kana
    first_name_kana + '' + last_name_kana
  end

  def customer_status
    if is_withdrawal == true
      "退会"
    else
      "有効"
    end
  end

end