class CustomersController < ApplicationController

  def customer
  end

  get '/customers/login' do
  #  "raise params.inspect"
    redirect "/show"
  end

  get '/customers/Signup' do

    redirect "/show"
  end

  get '/show' do
    "Hello World"
  end



end
