require 'rack-flash'

  class CustomersController < ApplicationController

    use Rack::Flash

    get '/main_menu' do
      redirect_if_not_logged_in
      erb :'/customers/main_menu'
    end

    get '/customers' do
      redirect_if_not_logged_in
        @customers = Customer.all
      erb :'/customers/index'
    end

    get '/customers/:id' do
      @customer = Customer.find_by(id: params[:id])
      if logged_in? && current_customer == @customer
        erb :'/customers/show'
      else
        redirect "/login"
      end
    end


    get '/customers/:id/edit' do
      @customer = Customer.find_by(id: params[:id])
      if logged_in? && current_customer == @customer
        erb :'/customers/edit'
      else
        redirect "/login"
      end
    end

    patch '/customers/:id' do
      if current_customer == @customer
        @customer = Customer.find_by(id: params[:id])
          @customer.name = params["customer"]["name"]
          @customer.email = params["customer"]["email"]
          @customer.save
        redirect to "/customers/#{@customer.id}"
      else
        redirect "/login"
      end
    end

    delete '/customers/:id/delete' do
      if logged_in?
        @customer = Customer.find_by(id: params[:id])
        if current_customer == @customer
          @customer.save
          #  @customer.delete   # Do not want customer to delete it's own account!
          flash[:message] = "Sorry, You can not delete your account.  Good Try!"
          erb :'/customers/show'
        else
        redirect "/login"
      end
    end
  end

end
