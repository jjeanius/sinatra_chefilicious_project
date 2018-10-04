class MealkitsController < ApplicationController

  get '/mealkits/new' do     # get requst /new action to create mealkit
    if logged_in?
      current_customer = @customer
      erb :'mealkits/new_mealkits'
    else
      redirect "/login"
    end
  end

  post '/mealkits/new_mealkits' do
    if !params[:name][:ingredients][:serving_size][:time].empty?
      @mealkit = Mealkit.new(:name =>params[:name], :ingredients =>params[:ingredients], :time =>params[:time], :serving_size =>params[:serving_size])
      @customer.mealkits << mealkit
      @customer.save
       redirect "/mealkits/#{@mealkits.id}"
     #  else
       #  redirect "/new"
   #    end
     end
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

  delete '/mealkits/:id/delete' do
    if logged_in?
    @mealkit = Mealkit.find_by_id(params[:mealkit_id])
      @mealkit && @mealkits.user == current_user
          @mealkits.destroy
             redirect "/mealkits"
           else
             redirect "/login"
           end
         end

       redirect ":/mealkits"
  end

  get '/mealkits/logout' do
    if logged_in?
    session.destroy
    redirect '/login'
    end
 end


end
