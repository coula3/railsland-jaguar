module CustomersHelper
    def select_service_insurance
        options ||= {"Yes" => true, "No" => false} 
    end

    def service_customers
        link_to 'Service Customers', customers_path
    end

    def pluralize_customer(collection)
        pluralize(collection.size, 'Customer')
    end
end
