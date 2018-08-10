module ContactSteps

  def contact_row_selector(contact)
    ".contact-row[data-contact-id='#{contact.id}']"
  end

  def contact_row(contact)
    find(contact_row_selector(contact))
  end

  def have_contact(contact)
    have_selector(contact_row_selector(contact))
  end

end
