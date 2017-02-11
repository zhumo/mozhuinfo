module AuthenticationSteps
  def log_in_successfully
    attempt_login(ENV['AUTH_USERNAME'], ENV['AUTH_PASSWORD'])
    expect(current_path).to eq(blogs_path)
  end

  def attempt_login(username, password)
    visit login_path
    fill_in 'Username', with: username
    fill_in 'Password', with: password
    click_on 'Log In'
  end
end
