module CustomersHelper
    def select_service_insurance
        options ||= {"Yes" => true, "No" => false} 
    end

    def service_customers
        link_to 'Service Customers', customers_path
    end

    def pluralize_customer(collection)
        pluralize(collection.size, 'Customer').dup.concat(" with Service Insurance")
    end

    def new_appointment(customer)
        link_to 'Create New Appointment', new_customer_appointment_path(customer)
    end
end
