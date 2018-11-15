module UsersHelper
  def activation_text(enabled)
    enabled ? 'Enabled' : 'Disabled'
  end

  def activation_link_text(enabled)
    enabled ? 'Deactivate' : 'Activate'
  end

  def roles_user
    User.roles.keys.reject { |role| role == 'admin' }
  end
end
