module Exhibits
  class User < Exhibit
    exhibit_model :user

    def formatted_phone_number
      number_to_phone(user_record.phone_number)
    end

    def show_path
      route_path(:user, user_record)
    end

    def edit_path
      route_path(:edit_user, user_record)
    end

    class << self
      def applicable_to?(object)
        object.is_a?(::User)
      end
    end
  end
end
