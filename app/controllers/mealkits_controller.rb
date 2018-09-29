class MealkitsController < ApplicationController


  delete '/delete' do
    if logged_in? &&  @customer.id = session[:id]
    @mealkit.destory
  end

  end








end
