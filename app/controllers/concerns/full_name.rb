module FullName
    module InstanceMethods
        def full_name
            ["#{self.first_name}", "#{self.last_name}"].join(" ")
        end
    end
end