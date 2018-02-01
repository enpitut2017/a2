class StaticPagesController < ApplicationController
  def contact
  end

  def usage
  end

  def map
  end

  def image
    @item = Item.find(params[:id])
  end
end
