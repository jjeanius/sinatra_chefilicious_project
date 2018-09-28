class CustomersController < ApplicationController

  def customer
  end

  get '/customers/login' do
  #  "raise params.inspect"
    redirect "/show"
  end

  get '/customers/Signup' do
    "Hello World"
    redirect "/show"
  end



end
