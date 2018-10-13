class ApplicationController < Sinatra::Base

  register Sinatra::ActiveRecordExtension

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "mealkits"
    enable :sessions
    require 'sinatra/flash'
    enable :sessions

  end

  get "/" do
    erb :'/welcome'
  end

  helpers do

     def logged_in?
       !!session[:customer_id]
     end

     def current_customer
       Customer.find(session[:customer_id])
     end

   end

end
