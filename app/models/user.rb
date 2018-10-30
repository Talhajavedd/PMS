class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  validate :validate_username
  validates :username, presence: :true, uniqueness: { case_sensitive: false }

  ADMIN = 'admin'

  enum role: [:user, :manager, :admin]

  after_initialize :set_default_role, :if => :new_record?
  scope :non_admin_users, -> { where.not(role: :admin) }

  attr_writer :login

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def login
    @login || self.username || self.email
  end

  def toggle_enable
    self.toggle(:enable).save
  end

  def set_default_role
    self.role ||= :user
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    conditions = warden_conditions.dup
    conditions[:email].downcase! if conditions[:email]
    if login = conditions.delete(:login)
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def active_for_authentication?
    super && enable?
  end

  def inactive_message
    enable? ? super : :not_enable
  end

  def self.roles_except_admin
    self.roles.reject{ |role, _| role == ADMIN }
  end
end
