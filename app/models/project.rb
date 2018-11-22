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

  def self.search_with(params, user = nil)
    params = {} if params.blank?
    search_params = default_search_options(params)
    search_params[:with][:user_ids] = user.id if user && user.user?
    search(Riddle.escape(params[:search].to_s), search_params)
  end

  def self.default_search_options(pagination_options)
    {
      with: {},
      page: pagination_options[:page],
      per_page: 10,
      sql: {
        include: [:client]
      }
    }
  end
end
