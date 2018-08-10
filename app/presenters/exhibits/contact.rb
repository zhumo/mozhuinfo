module Exhibits
  class Contact < Exhibit
    exhibit_model :contact

    def formatted_phone_number
      number_to_phone(contact_record.phone_number)
    end

    def show_path
      route_path(:contact, contact_record)
    end

    def edit_path
      route_path(:edit_contact, contact_record)
    end

    class << self
      def applicable_to?(object)
        object.is_a?(::Contact)
      end
    end
  end
end
