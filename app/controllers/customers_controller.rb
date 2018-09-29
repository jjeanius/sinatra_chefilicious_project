class CustomersController < ApplicationController


  get '/signup' do      #  signup/get request/create action
    if logged_in? && @customer = current_customer
      redirect "/show"
    else
      erb :'/signup'
    end
  end

  post '/signup' do     #    signup/get request create post
    @customer = Customer.new(params)
  end


  get '/show' do
    "Hello World"
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
