module ApplicationHelper
  def is_current_user?(user)
    logged_in? && (current_user == user)
  end
end

