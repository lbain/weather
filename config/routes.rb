Weather::Application.routes.draw do

  match '/weather' => 'weather#zipcode_inquiry', via: [:get], :as => :zipcode_inquiry
  match '/weather' => 'weather#show_weather', via: [:post], :as => :new_zipcode

end
