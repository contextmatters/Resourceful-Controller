module ResourcefulController
  module ResourceIdentification
    extend ActiveSupport::Concern

    delegate :resource_name, :resources_name, :resource_class, :to => :klass

    def resource_params
      named_param_method = :"#{resource_name}_params"
      if respond_to?(named_param_method)
        send named_param_method
      elsif respond_to?(:unsafe_params)
        unsafe_params[resource_name]
      else
        raise "ResourcefullyNameTheParams"
      end
    end

    module ClassMethods
      def resource_name
        resources_name.singularize
      end

      def resources_name
        controller_name
      end

      def resource_class
        resource_name.classify.constantize
      end
    end
  end
end
