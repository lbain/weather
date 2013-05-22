class WeatherController < ApplicationController

  def zipcode_inquiry
  end

  def show_weather
    # check for form param
    unless params[:zipcode_form] && params[:zipcode_form][:zipcode]
      flash[:error] = "No zipcode given"
      redirect_to zipcode_inquiry_path
      return
    end
    zipcode = params[:zipcode_form][:zipcode]
    # check for correct format of the zipcode
    unless !!(zipcode =~ /\d{5}/)
      flash[:error] = "Invalid zip code format."
      redirect_to zipcode_inquiry_path
      return
    end

    # everything was correct with the zipcode formatting
    wunderground = Wunderground.new("ed044d75b91fb500")
    wunderground.throws_exceptions = true
    begin
      #try to get the conditions for the given zipcode
      conditions = wunderground.conditions_for(zipcode)
    rescue Exception => e
      if !!(e.message =~ /querynotfound/)
        # the user entered an invalid zipcode
        flash[:error] = "Zipcode not found."
      else
        # something went wrong with the call (most likely a time out) - give generic error message
        flash[:error] = "Error getting weather."
      end
      redirect_to zipcode_inquiry_path
      return
    end

    # everything was correct about the zipcode info, we now have the data back from the api
    @city = conditions["current_observation"]["display_location"]["city"]
    @state = conditions["current_observation"]["display_location"]["state_name"]
    @temp_f = conditions["current_observation"]["temp_f"]
  end
end
