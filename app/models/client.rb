class Client < ApplicationRecord
  has_many :projects, dependent: :destroy
  after_save ThinkingSphinx::RealTime.callback_for(:client)
  after_save ThinkingSphinx::RealTime.callback_for(:project, [:projects])

  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/.freeze

  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_USERNAME_REGEX }, length: { minimum: 5, maximum: 30 }
  validates :company, presence: true, length: { minimum: 5, maximum: 30 }, format: { with: VALID_USERNAME_REGEX }

  def self.search_with(params)
    params = {} if params.blank?
    search_params = default_search_options(params)
    search(Riddle.escape(params[:search].to_s), search_params)
  end

  def self.default_search_options(pagination_options)
    {
      page: pagination_options[:page],
      per_page: 10
    }
  end
end
