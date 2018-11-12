require 'rack-flash'

class MealkitsController < ApplicationController

  use Rack::Flash

  get '/mealkits/new' do     # get requst - '/request to load the form for new mealkit
    if logged_in?
      @customer = current_customer
      erb :'mealkits/new'
    else
      redirect "authenticate/login"
    end
  end

  post '/mealkits' do    # post request / it responds to the post request
    if !params[:mealkit].empty?    # true
      @mealkit = Mealkit.create(params[:mealkit])  # create a mealkit based from the params from the form
        @customer = current_customer
          @customer.mealkits << @mealkit
            @mealkit.save
            flash[:message] = "Successfully created a Meal Kit!"
            redirect to ("/mealkits/create")
          else
         redirect "/mealkits/new"
    end
  end

  get '/mealkits/create' do   # get request / new show mealkit action   3/3
    @mealkit = Mealkit.last
    erb :'/mealkits/create'
  end

  get '/mealkits/:id/edit' do    # get request/ load edit action   1/2
    if logged_in?
      @customer = current_customer
        mealkits = Mealkit.all
          @mealkit = Mealkit.find_by(params[:id])
        erb :'/mealkits/edit'
    else
      redirect "authenticate/login"
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
          @mealkits = Mealkit.all   # collect all mealkits
        erb :'/mealkits/index'
      end
    end

    get '/mealkits/:id' do   # get request / show/ dynamic routing - accessing view through the params hash
      if logged_in?
        @customer = current_customer
          @customer = Customer.find(session[:customer_id])  #  access session customer_id through instance variable customer
            mealkit = Mealkit.find_by(id: params[:id])  # access params id of mealkit through params hash
          @customer.mealkits       #  set it into customer
        erb :'/mealkits/by_customer'
      else
        redirect "authenticate/login"
      end
    end

    delete '/mealkits/:id/delete' do      #  post request / delete a mealkit action
      mealkit = Mealkit.find_by(id: params[:id])   #  find the mealkit by access params id of mealkit
        mealkit.delete

        flash[:message] = "Meal Kit #{mealkit.id} is deleted!"
        redirect to '/customers/update'
    end

end
