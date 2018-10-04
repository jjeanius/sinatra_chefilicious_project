class MealkitsController < ApplicationController

  get '/mealkits/new' do     # get requst /new action to create mealkit
    if logged_in?
      current_customer = @customer
    erb :'mealkits/new'
    else
      redirect "/login"
    end
  end

   post '/mealkits/new_mealkits' do       #  post request /create new action
    # current_customer = @customer
     @mealkit = Mealkit.create(params[:mealkit])
    #   @mealkit = Mealkit.create(:name =>params[:name], :ingredients =>params[:ingredients], :time =>params[:time], :serving_size =>params[:serving_size])
     if !params[:name][:ingredients][:serving_size][:time].empty?
       @customer.mealkits << mealkit
     end
       @customer.save
       redirect "/mealkits/#{@mealkit.id}"
  #  else
  #      redirect "/mealkits/new"
  #  end
  end

  get '/mealkits' do    #   get request, show action
    if logged_in?
      current_customer = @customer
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


  get '/mealkits/logout' do
    logged_in?
    session.destroy
    redirect '/login'
 end


end
