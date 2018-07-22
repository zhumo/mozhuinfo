module UserSteps

  def user_row_selector(user)
    ".user-row[data-user-id='#{user.id}']"
  end

  def user_row(user)
    find(user_row_selector(user))
  end

  def have_user(user)
    have_selector(user_row_selector(user))
  end

end
