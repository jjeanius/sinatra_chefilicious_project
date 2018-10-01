class CustomersController < ApplicationController

  get '/signup' do      #  signup/get request/create action
    if logged_in? && @customer = current_customer
      redirect "/show"
    else
      erb :'/customers/signup'
    end
  end

  post '/signup' do     #    signup/get request create action
    @customer = Customer.new(:name =>params[:name], :username =>params[:username], :email =>params[:email], :password =>params[:password])
    if @customer.save
      @customer.id = session[:customer_id]
      redirect "/show"
    else
      redirect "/signup"
    end
  end

  get '/login' do      #  login/get request/create action
    if logged_in?
      redirect "/show"
    else
      redirect "/show"
    end
  end

   post '/login' do     #    get request create action
     @customer = Customer.find_by(:username =>params[:username])
       if @customer && @customer.authenticate(params[:password])
         @customer.id = session[:customer_id]
         redirect "/show"
       else
          redirect "/signup"
       end
   end

  get '/show' do      #  show/get request show action
     @customer = Customer.find_by_id(params[:id])
     erb :show
   end


 get '/logout' do
      if logged_in?
        session.destroy
        redirect '/login'
      else
        redirect '/show/:id'
      end
   end


end
