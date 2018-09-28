class CustomersController < ApplicationController

  def customer
  end

  get '/customers/login' do
  #  "raise params.inspect"
  erb :'/customer/login'
  end



end
