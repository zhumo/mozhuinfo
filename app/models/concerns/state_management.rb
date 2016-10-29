module Concerns
  module StateManagement
    def has_state_for(action_name, state_name)
      attribute_name = "#{state_name}_at".to_sym
      # mark_as_deleted
      setter_method_name = "mark_as_#{state_name}".to_sym
      define_method setter_method_name do
        public_send("#{attribute_name}=", Time.zone.now)
      end
      # delete
      define_method action_name.to_sym do
        public_send(setter_method_name)
        save
      end
      # delete!
      define_method "#{action_name}!".to_sym do
        public_send(setter_method_name)
        save!
      end
      # mark_as_not_deleted
      unsetter_method_name = "mark_as_not_#{state_name}".to_sym
      define_method unsetter_method_name do
        public_send("#{attribute_name}=", nil)
      end
      # undelete
      define_method "un#{action_name}".to_sym do
        public_send(unsetter_method_name)
        save
      end
      # undelete!
      define_method "un#{action_name}!".to_sym do
        public_send(unsetter_method_name)
        save!
      end
      # deleted?
      check_state_method = "#{state_name}?"
      define_method check_state_method.to_sym do
        public_send(attribute_name).present?
      end
      # not_deleted?
      define_method "not_#{check_state_method}".to_sym do
        !public_send("#{state_name}?")
      end

      # deleted
      scope state_name.to_sym, -> { where.not(attribute_name => nil) }
      # not_deleted
      scope "not_#{state_name.to_sym}", -> { where(attribute_name => nil) }
    end
  end
end
