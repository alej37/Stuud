class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         :omniauthable, omniauth_providers: [:stripe_connect]

  def can_receive_payments?
    uid? &&
    provider? &&
    access_code? &&
    publishable_key?
  end

  # user relations and dependencies
  has_many :clients, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :clients, through: :bookings
  has_many :events, dependent: :destroy

end
