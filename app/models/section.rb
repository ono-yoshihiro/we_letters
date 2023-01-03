class Section < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :letters, dependent: :destroy
  has_many :payment_budgets, dependent: :destroy
  has_many :send_letters, dependent: :destroy
  has_many :boards, dependent: :destroy

  validates :name, presence: true
  validates :pic_name, presence: true
  validates :telephone_number, presence: true

end