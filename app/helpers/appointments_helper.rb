module AppointmentsHelper
    def select_status
        status ||= ["open", "rescheduled", "cancelled", "no-show", "service completed"]
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
        "Service Insurance" if collection.distinct.count(:customer_id) > 1
    end
end
