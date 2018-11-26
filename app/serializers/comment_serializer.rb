class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body

  attribute :user do |comment|
    { 'id' => comment.user.id, 'username' => comment.user.username } 
  end
end
