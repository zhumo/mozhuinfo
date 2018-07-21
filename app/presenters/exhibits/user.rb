module Exhibits
  class User < Exhibit
    exhibit_model :user

    def show_path
      route_path(:user, user_record)
    end

    class << self
      def applicable_to?(object)
        object.is_a?(::User)
      end
    end
  end
end
