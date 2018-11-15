class Project < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :client
  has_many :payments, dependent: :destroy
  has_many :time_logs, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  after_save ThinkingSphinx::RealTime.callback_for(:project)

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  VALID_NAME_REGEX = /\A[a-zA-Z0-9]+\z/.freeze

  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_NAME_REGEX }, length: { minimum: 5, maximum: 30 }

  def self.search_project(params, user)
    if user.role == 'user'
      search(params, with: { user_ids: user.id }, include: :client)
    else
      search(params, include: :client)
    end
  end
end
