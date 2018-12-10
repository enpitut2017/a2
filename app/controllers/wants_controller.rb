class WantsController < ApplicationController
  def home
    @wants = Want.all.order('created_at DESC')
  end

  def new
    @want = Want.new(content: params[:content])
    @want.save
    redirect_to action: "home"
  end
end
