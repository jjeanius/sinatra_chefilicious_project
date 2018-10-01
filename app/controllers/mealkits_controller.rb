class MealkitsController < ApplicationController

  get '/mealkits/new' do     # get requst /new action to create mealkit
    if logged_in?
      @customer = current_customer
    erb :'/mealkits/new'
  #  else
  #    redirect "/login"
    end
  end

   post '/mealkits' do       #  post request /create new action
     if !params[:ingredients].empty?
      @mealkit = Mealkit.create(:name =>params[:name], :ingredients =>params[:ingredients], :customer_id =>params[:customer_id], :time =>params[:time], :serving_size =>params[:serving_size])
      @customer = current_customer
      @customer.mealkits << @mealkit
      @customer.save
      redirect "/mealkits"
    else
      redirect "/mealkits/new"
    end

  end








  get '/mealkits' do    #   get request, show action
    if logged_in?
      @customer = Customer.find(session[:customer_id])
      @mealkits = Mealkit.all
      erb :'/mealkits/mealkits'
    else
      redirect "/login"
    end
  end




  get '/mealkits/:id/edit' do    # get request/ load edit action
     @mealkits = Mealkit.find_by_id(params[:id])
     erb :edit
  end

  patch '/mealkits/:id' do   #  patch request / edit action
    @mealkit = Mealkit.find_by_id(params[:id])
    @mealkit.ingredients = params[:ingredients]
    @mealkit.name = params[:name]
    @mealkit.time = params[:time]
    @mealkit.serving_size = params[serving_size]
    @mealkit.save
    redirect to "/mealkits/#{@mealkit.id}"
  end





  end
