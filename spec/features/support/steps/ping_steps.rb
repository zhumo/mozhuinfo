module PingSteps
  def ping_form
    find(".ping-form")
  end

  def pings_table_selector
    ".pings-table"
  end

  def pings_table
    find(pings_table_selector)
  end

  def have_pings_table
    have_selector(pings_table_selector)
  end

  def ping_row_selector(ping)
    ".ping__row[data-ping-id='#{ping.id}']"
  end

  def ping_row(ping)
    find(ping_row_selector(ping))
  end

  def have_ping(ping)
    have_selector(ping_row_selector(ping))
  end
end
