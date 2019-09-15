class Messenger

  def send_sms(from: ENV["TWILIO_PHONE_NUMBER"], to: ENV["AUTH_PHONE_NUMBER"], body:)
    client.api.account.messages.create(from: from, to: to, body: body).sid.present?
  end

  private

  def client
    @client ||= Twilio::REST::Client.new(
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_AUTH_TOKEN"],
    )
  end
end
