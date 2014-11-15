json.array!(@volunteers) do |volunteer|
  json.extract! volunteer, :id, :first_name, :last_name, :contact_number, :notes
  json.url volunteer_url(volunteer, format: :json)
end
