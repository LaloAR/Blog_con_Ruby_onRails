class MainController < ApplicationController
  def home
    @post = Post.new
    @posts = Post.all
  end

  def unregistered
  	
  end

  protected
	  # Retorna el layout que va a implementar Rails
	  def set_layout
	  	return "landing" if action_name == "unregistered"
	  	super
	  end
end
