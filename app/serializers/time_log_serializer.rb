class TimeLogSerializer
  include FastJsonapi::ObjectSerializer
  attributes :time_log, :date

  attribute :user do |time_log|
    { 'id' => time_log.user.id, 'username' => time_log.user.username } 
  end
end
