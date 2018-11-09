class User < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  validate :validate_username
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  ADMIN = 'admin'.freeze

  enum role: %i[user manager admin]

  after_initialize :set_default_role, if: :new_record?
  scope :non_admin_users, -> { where.not(role: :admin) }

  attr_writer :login

  def validate_username
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  def login
    @login || username || email
  end

  def toggle_enable
    toggle(:enable).save
  end

  def set_default_role
    self.role ||= :user
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    conditions[:email].downcase! if conditions[:email]
    if (login = conditions.delete(:login))
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions[:username].nil?
      where(conditions).first
    else
      where(username: conditions[:username]).first
    end
  end

  def active_for_authentication?
    super && enable?
  end

  def inactive_message
    enable? ? super : :not_enable
  end

  def self.roles_except_admin
    roles.reject { |role, _| role == ADMIN }
  end
end
