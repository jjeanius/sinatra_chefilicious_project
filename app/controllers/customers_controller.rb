class CustomersController < ApplicationController

  get '/signup' do      #  signup/get request/create action
    if logged_in? && @customer = current_customer
      redirect "/main_menu"
    else
      erb :'/customers/signup'
    end
  end

  post '/signup' do     #    signup/get request create action
    @customer = Customer.new(:name =>params[:name], :username =>params[:username], :email =>params[:email], :password =>params[:password])
    if @customer.save
      session[:customer_id] = @customer.id
      redirect "/customers/main_menu"
    else
      redirect "/signup"
    end
  end

  get '/login' do      #  login/get request/create action
    if logged_in?
      redirect "/main_menu"
    else
      erb :'/customers/login'
    end
  end

   post '/login' do     #    get request create action
     @customer = Customer.find_by(:username =>params[:username])
       if @customer && @customer.authenticate(params[:password])
         session[:customer_id] = @customer.id
         redirect "/customers/main_menu"
       else
          redirect "/signup"
       end
   end

  get '/customers/main_menu' do      #  show/get request show action
     erb :'/customers/main_menu'
   end

   get '/logout' do
      if logged_in?
        session.destroy
        redirect '/login'
      else
        redirect '/customers/main_menu'
      end
   end

end
