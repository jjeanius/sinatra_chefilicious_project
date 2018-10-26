class ApplicationController < Sinatra::Base

  register Sinatra::ActiveRecordExtension
  enable :sessions

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "mealkits"

    require 'sinatra/flash'
    enable :sessions

  end

  get "/" do    # Get request load the welcome form - rendering the erb of welcome view
    erb :'/welcome'
  end

  helpers do
     def logged_in?     #  return true or false
       !!session[:customer_id]
     end

     def current_customer
       Customer.find(session[:customer_id])   # return instance of user
     end
   end

end
