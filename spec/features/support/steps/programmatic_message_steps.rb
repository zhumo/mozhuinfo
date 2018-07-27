module PingSteps
  def ping_form
    find(".ping-form")
  end

  def pings_list
    find(".pings-list")
  end

  def ping_row_selector(ping)
    ".ping__row[data-ping-id='#{ping.id}']"
  end

  def ping_row(ping)
    find(ping_row_selector(ping))
  end

  def have_ping(ping)
    has_selector(ping_row_selector(ping))
  end
end
