require 'rack-flash'

  class MealkitsController < ApplicationController

    use Rack::Flash

    get '/mealkits' do
      redirect_if_not_logged_in
        @mealkits = Mealkit.all
      erb :'/mealkits/index'
    end

    get '/mealkits/new' do
      redirect_if_not_logged_in
        @customer = current_customer
      erb :'mealkits/new'
    end

    post '/mealkits' do
      if logged_in? && current_customer
        if !params[:mealkit].empty?   # true
          @mealkit = Mealkit.create(params[:mealkit])  # create a mealkit based from the params from the form
            current_customer.mealkits << @mealkit
              @mealkit.save
            flash[:message] = "Successfully created a Meal Kit!"
            redirect "/mealkits/#{@mealkit.id}"
          else
            redirect "/mealkits/new"
          end
        end
    end

    get '/mealkits/:id' do
      if logged_in?
        @mealkit = Mealkit.find_by(id: params[:id])
        if @mealkit.customer == current_customer
          erb :'/mealkits/show'
        else
          redirect "/mealkits"
        end
      end
    end

    get '/mealkits/:id/edit' do
      if logged_in?
        @mealkit = Mealkit.find_by(id: params[:id])
        #  if @mealkit.customer == current_customer
        erb :'/mealkits/edit'
      else
        redirect "/main_menu"
        #  end
      end
    end

    patch '/mealkits/:id' do
      if logged_in?
        @mealkit = Mealkit.find_by(id: params[:id])
        if @mealkit.customer == current_customer
              @mealkit.update(name: params[:mealkit][:name], ingredients: params[:mealkit][:ingredients], time: params[:mealkit][:time], serving_size: params[:mealkit][:serving_size])
            flash[:message] = "Successfully updated!"
            redirect to ("/mealkits/#{@mealkit.id}")
         else
          redirect "/login"
        end
      end
    end

    delete '/mealkits/:id/delete' do
      if logged_in?
          @mealkit = Mealkit.find_by_id(params[:id])
          if current_customer ==  @mealkit.customer
            @mealkit.delete
            flash[:message] = "Meal Kit #{@mealkit.id} is deleted!"
            erb :'/mealkits/show'
          else
            redirect to '/login'
        end
      end
    end

end
