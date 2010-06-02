module User::Editable
  def editable_by?(user, is_moderator = nil)
    is_moderator = forum.moderated_by?(user) if is_moderator.nil?
    user && (user.id == user_id || is_moderator)
  end
end

