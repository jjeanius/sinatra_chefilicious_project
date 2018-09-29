class CustomersController < ApplicationController


  get '/signup' do      #  signup/get request/create action
    if logged_in? && @customer = current_customer
      redirect "/show"
    else
      erb :'/customers/signup'
    end
  end

  post '/signup' do     #    signup/get request create action
    @customer = Customer.new(:name =>params[:name], :username =>params[:usrname], :email =>params[:email], :password =>params[:password])
    if @customer.save
      @customer.id = session[:customer_id]
      redirect "/show"
    else
      erb :'/customers/signup'
    end
  end

  get '/login' do      #  login/get request/create action
    if logged_in?
      redirect "/show"
    else
      erb :'/customers/login'
    end
  end

  post '/login' do     #    signup/get request create action
    @customer = Customer.find_by(:username =>params[:usrname]) || @customer = Customer.find_by(:email =>params[:email])
      @customer.password = session[:customer_password]
      redirect "/show"
    else
      erb :'/customers/signup'
    end
  end

  get '/show' do     #  show/get request show action
    @customer = Customer.find_by_id(params[:id])
    erb :'/customers/show'
  end

  get '/logout' do
    if logged_in?
      session.destroy
        redirect '/login'
      else
        redirect '/show'
      end
  end


helpers do

  def logged_in?
    !!session[:user_id]
  end

  def current_customer
    Customer.find(session[:user_id])
  end

end

end
