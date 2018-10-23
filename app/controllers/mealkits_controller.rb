require 'rack-flash'

class MealkitsController < ApplicationController

  use Rack::Flash

  get '/mealkits/new' do     # get requst /new action to create mealkit  1/3
    if logged_in?
      @customer = current_customer
      erb :'mealkits/new'
    else
      redirect "/login"
    end
  end

  post '/mealkits/:id' do    # post request / new action to post the new mealkit   2/3
    if !params[:mealkit].empty?    # true
      @mealkit = Mealkit.create(params[:mealkit])
      @customer = current_customer
      @customer.mealkits << @mealkit
      @mealkit.save

      flash[:message] = "Successfully created a Meal Kit!"
      redirect to ("/mealkits/new_mealkits")
    else
      redirect "/mealkits/new"
    end
  end

  get '/mealkits/new_mealkits' do   # get request / new show mealkit action   3/3
    @mealkit = Mealkit.last
    erb :'/mealkits/new_mealkits'
  end

  get '/mealkits/edit' do    # get request/ load edit action   1/2
    if logged_in?
      @customer = current_customer
        mealkits = Mealkit.all
        @mealkit = Mealkit.find_by(params[:id])  # @mealkit = Mealkit.find_by_id(params["mealkit.id"])
      erb :'mealkits/edit'
    else
      redirect '/login'
    end
  end

  patch '/mealkits/:id' do   #  patch request / edit action 2/2 it needs to match action of form submitted for get mealkit/edit
    @mealkit = Mealkit.find_by(id: params[:id])   #now id is no longer nil because it is part of line 59
      @mealkit.update(name: params[:mealkit][:name], ingredients: params[:mealkit][:ingredients], time: params[:mealkit][:time], serving_size: params[:mealkit][:serving_size])
        @mealkit.save

    flash[:message] = "Successfully updated!"
    redirect to ("/mealkits/by_customer")
  end

    get '/mealkits' do   #  get request / show all mealkit action
      if logged_in?
        @customer = current_customer
          @customer = Customer.find(session[:customer_id])
          @mealkits = Mealkit.all
      erb :'/mealkits/index'
    end
    end

    get '/mealkits/:id' do   # get request / show one cusotmer mealkits
      if logged_in?
        @customer = current_customer
          @customer = Customer.find(session[:customer_id])
          mealkit = Mealkit.find_by(id: params[:id])
          @customer.mealkits
        erb :'/mealkits/by_customer'
      else
        redirect "customers/login"
      end
    end

    delete '/mealkits/:id/delete' do      #post '/mealkits/:id/delete' do     #  post request / delete a mealkit action
      mealkit = Mealkit.find_by(id: params[:id])
        mealkit.delete
        flash[:message] = "Meal Kit #{mealkit.id} is deleted!"
        redirect to '/mealkits/by_customer'
    end

    get '/logout' do
      if logged_in?
        session.destroy
        redirect "/login"
      end
    end

end
