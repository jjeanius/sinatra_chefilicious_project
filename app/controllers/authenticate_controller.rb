require 'rack-flash'

class AuthenticateController < ApplicationController

  use Rack::Flash

  get '/signup' do      # Get request  '/ signup route - rendiering sigup.erb view
    erb :'authenticate/signup'
  end

  post '/signup' do     # Post request '/signup' route -load the signup form  - crete new signup action
    @customer = Customer.new(:name =>params[:name], :username =>params[:username], :email =>params[:email], :password =>params[:password])
    # responds to post request, create a new customer based on params from the form
    if @customer.save && @customer.username !=""   # save the new customer
      session[:customer_id] = @customer.id
      flash[:message] = "Thanks for signing up!"  #  provide a msg to the customer
      redirect to ("/main_menu")    #   action redirect to the "main_menu".erb view
    else
      flash[:message] = "Please Try Again!"
      redirect to ("/signup")
   end
 end

  get '/login' do      #  Get request - '/login' route - load the login form - create a login action
    if logged_in?
      redirect "/main_menu"
    else
      erb :'/authenticate/login'
    end
  end

   post '/login' do     #    post request - '/login' route
     @customer = Customer.find_by(:username =>params[:username])
       if @customer && @customer.authenticate(params[:password])
         session[:customer_id] = @customer.id  # if customer authenticate / we set the customer id

         flash[:message] = " Successfully Login!"
         redirect "/main_menu"   # and redirect to main_menu
       else
         flash[:message] = "Please Try Again!"
         redirect "/login"
       end
   end

   get '/logout' do   #  get request - '/logout' route
     if logged_in?
       session.destroy
       redirect "/login"
     end
   end

end
