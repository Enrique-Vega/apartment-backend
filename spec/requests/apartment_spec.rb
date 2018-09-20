require 'rails_helper'

describe "Apartment API" do

  it "gets a list of apartments" do
    Apartment.create(address_1:"125 J st", city:"San Diego", postal_code:12345, state:"CA", country:"USA", manager_name:"Bob Dylan", manager_phone:6198089038, manager_time: "MON-FRI 9:00AM - 5:00PM")
    #make request to API
    get '/apartments'
    json = JSON.parse(response.body)
    # puts json
    expect(response).to be_success
    expect(json.length).to eq 1
  end

  it "can create entry" do
    test_apartment = {
        apartment: {
          address_1:"125 J st", city:"San Diego", postal_code:12345, state:"CA", country:"USA", manager_name:"Bob Dylan", manager_phone:6198089038, manager_time: "MON-FRI 9:00AM - 5:00PM"
    }
  }

  #add apartment
    post '/apartments', params: test_apartment
    json = JSON.parse(response.body)
    # puts json
    expect(response).to be_success
    new_apartment = Apartment.first
    expect(new_apartment.manager_name).to eq('Bob Dylan')
  end

   # show method test
  it "can view a single entry" do
    apartment = Apartment.create(address_1:"125 J st", city:"San Diego", postal_code:12345, state:"CA", country:"USA", manager_name:"Bob Dylan", manager_phone:6198089038, manager_time: "MON-FRI 9:00AM - 5:00PM")

    get "/apartments/#{apartment.id}"
    json = JSON.parse(response.body)
    # puts json
    expect(response).to be_successful
    # expect(response.address_1).to eq 1
  end

  it "can destroy a single entry" do
    apartment = Apartment.create(address_1:"125 J st", city:"San Diego", postal_code:12345, state:"CA", country:"USA", manager_name:"Bob Dylan", manager_phone:6198089038, manager_time: "MON-FRI 9:00AM - 5:00PM")

    # gets list of apartments
    get '/apartments'
    # converts response to ruby hash
    json = JSON.parse(response.body)
    puts json
    expect(response).to be_successful
    expect(json.length). to eq 1

    # Destroys list of apartments
    delete "/apartments/#{apartment.id}"

    # gets list of apartments with deleted value
    get '/apartments'
    # converts response to ruby hash
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json.length). to eq 0
  end

  it "can update single entry" do
    apartment_params = {
      apartment: {
        address_1:"125 J st", city:"Los Angeles", postal_code:12345, state:"CA", country:"CAN", manager_name:"Bob Dylan", manager_phone:6198089038, manager_time: "MON-FRI 9:00AM - 5:00PM"
      }
    }

    apartment = Apartment.create(address_1:"125 J st", city:"San Diego", postal_code:12345, state:"CA", country:"USA", manager_name:"Bob Dylan", manager_phone:6198089038, manager_time: "MON-FRI 9:00AM - 5:00PM")

    patch "/apartments/#{apartment.id}", params: apartment_params

    json = JSON.parse(response.body)
    # puts json
    expect(json['city']).to eq "Los Angeles"
    expect(json['country']).to eq "CAN"

  end

end
