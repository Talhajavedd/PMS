ThinkingSphinx::Index.define :user, with: :real_time do
  # fields
  indexes username, sortable: true
  indexes email, sortable: true

  has :role, type: :string
end
