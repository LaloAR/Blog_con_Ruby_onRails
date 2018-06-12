class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :set_layout
 # before_action :configurar_strong_params, if: :devise_controller?

  # El método sólo se va a ejecutar por las clases hijas o la clase misma
  protected
	  # Retorna el layout que va a implementar Rails
	  def set_layout
	  	"application"
	  end


end
