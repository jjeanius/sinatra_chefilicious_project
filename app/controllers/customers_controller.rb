class CustomersController < ApplicationController


  get '/signup' do      #  signup/get request/create action
    if logged_in? && @customer = current_customer
      redirect "/show/:id"
    else
      erb :'/customers/signup'
    end
  end

  post '/signup' do     #    signup/get request create action
    @customer = Customer.new(:name =>params[:name], :username =>params[:username], :email =>params[:email], :password =>params[:password])
    if @customer.save
      @customer.id = session[:customer_id]
      redirect "/show/#{@customer.id}"
    else
      redirect "/signup"
    end
  end

  get '/login' do      #  login/get request/create action
    if logged_in?
      redirect "/show/:id"
    else
      erb :'/customers/login'
    end
  end

   post '/login' do     #    signup/get request create action
     @customer = Customer.find_by(:username =>params[:username])
     @customer.id = session[:customer_id]
       if @customer && @customer.authenticate(params[:password])
         redirect "/show/#{@customer.id}"
       else
          redirect "/signup"
       end
   end

   get '/show/:id' do     #  show/get request show action
      @customer = Customer.find_by_id(params[:id])
    erb :'/customers/show'
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
