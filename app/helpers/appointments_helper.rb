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
end
