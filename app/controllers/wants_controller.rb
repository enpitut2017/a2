class WantsController < ApplicationController
  def home
    @wants = Want.all
  end

  def new
    @want = Want.new(content: params[:content])
    @want.save
    redirect_to action: "home"
  end
end
