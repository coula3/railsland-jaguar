module AppointmentsHelper
    def select_status
        status ||= ["Open", "Re-scheduled", "Cancelled", "No-show", "Service Completed"]
    end

    def veh_models
        models ||= ["Jaguar F-TYPE", "Jaguar XE", "Jaguar XE SV", "Jaguar XF", "Jaguar XJ", "Jaguar E-PACE", "Jaguar F-PACE", "Jaguar I-PACE"]
    end

    def model_years
        t = Time.now
        m_years ||=  ((t.year - 10)..t.year).to_a
    end

    def readable_date(object)
        object.date.strftime("%b %d, %Y")
    end

    def readable_time(object)
        object.time.strftime("%H:%M")
    end

    def display_customer_header(collection)
        "Customer" if collection.distinct.count(:customer_id) > 1
    end

    def display_service_insurance_header(collection)
        "Insurance" if collection.distinct.count(:customer_id) > 1
    end

    def service_appointments
        link_to 'Service Appointments', appointments_path
    end

    def service_appointments_by_status(appointment, single_customer, link_color)
        if single_customer
            appointment.status
        else
            link_to appointment.status, { controller: "appointments", status: appointment.status }, id: link_color, title: "View #{appointment.status} Appointments"
        end
    end

    def new_appointment(customer)
        link_to 'Create New Appointment', new_customer_appointment_path(customer)
    end

    def customer_appointments(customer)
        link_to "#{customer.first_name}'s Appointments", customer_appointments_path(customer)
    end
end
