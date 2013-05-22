Weather::Application.routes.draw do

  match '(*all)' => 'weather#zipcode_inquiry', via: [:get], :as => :zipcode_inquiry
  match '/' => 'weather#show_weather', via: [:post], :as => :new_zipcode

end
