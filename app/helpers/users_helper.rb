module UsersHelper
  def activation_text(enabled)
    enabled ? 'Enabled' : 'Disabled'
  end

  def activation_link_text(enabled)
    enabled ? 'Deactivate' : 'Activate'
  end
end
