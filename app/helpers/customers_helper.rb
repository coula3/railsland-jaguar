module CustomersHelper
    def select_service_insurance
        options ||= {"Yes" => true, "No" => false} 
    end

    def service_customers
        link_to 'Service Customers', customers_path
    end

    def count_of_customers_with_service_insurance(collection)
        pluralize(collection.size, 'Customer').dup.concat(" with Service Insurance")
    end
end
