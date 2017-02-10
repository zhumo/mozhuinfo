class Gatekeeper
  attr_reader :username, :password, :session_key

  delegate :token, to: :session_record, prefix: :session

  def initialize(username: nil, password: nil, session_key: nil)
    @username = username
    @password = password
    @session_key = session_key
  end

  def allow?
    active_session? || valid_credentials?
  end

  private

  def active_session?
    session_record.active?
  end

  def session_record
    @session_record ||= Session.find_by(token: session_key) || NullSession.new
  end

  def valid_credentials?
    (valid_username? && valid_password?).tap do |valid|
      store_session if valid
    end
  end

  def valid_username?
    ENV["AUTH_USERNAME"].present? && username == ENV["AUTH_USERNAME"]
  end

  def valid_password?
    ENV["AUTH_PASSWORD"].present? && password == ENV["AUTH_PASSWORD"]
  end

  def store_session
    @session_record = Session.create(token: SecureRandom.hex)
  end
end
