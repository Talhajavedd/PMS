class Project < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :client
  has_many :payments, dependent: :destroy
  has_many :time_logs, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  after_save ThinkingSphinx::RealTime.callback_for(:project)

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 5, maximum: 30 }

  def self.search_project(params, user, page)
    if user.role == 'user'
      search(params, with: { user_ids: user.id }, page: page, per_page: 10, include: :client)
    else
      search(params, page: page, per_page: 10, include: :client)
    end
  end
end
