module ServicesHelper
    def service_select(app, path)
        if !app.service
            hidden_field_tag "app[service_id]", app.service_id
            collection_radio_buttons(:service, :service_id, Service.all, :id, :name) do |b|
                b.label { b.radio_button + " " + b.text }
            end
        end
      end
end
