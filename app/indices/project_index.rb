ThinkingSphinx::Index.define :project, with: :real_time do
  # fields
  indexes name, sortable: true
  indexes client.name, sortable: true, as: :client

  has user_ids, type: :integer, multi: true, as: :user_ids
end
