class ProjectSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attributes :comments do |project, params|
    project.comments.includes(:user).page(params[:comment_page]).map { |comment| { 'body' => comment.body, 'user' => { 'id' => comment.user.id, 'username' => comment.user.username } } }
  end

  attributes :time_logs do |project, params|
    project.time_logs.includes(:user).page(params[:time_log_page]).map { |time_log| { 'hours' => time_log.time_log, 'date' => time_log.date, 'user' => { 'id' => time_log.user.id, 'username' => time_log.user.username } } }
  end

  has_many :users
  belongs_to :client
  has_many :payments
  has_many :attachments, as: :attachable
end
