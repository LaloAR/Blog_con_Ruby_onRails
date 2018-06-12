 	class Users::OmniauthCallbacksController < ApplicationController
 		def facebook
 			@user = User.from_omniauth(request.env["omniauth.auth"])

 			# Validar si el usuario se guardó adecuadamente
 			if @user.persisted?
 				@user.remember_me = true
 				# Autenticando al usuario y redireccionarlo al home
 				sign_in_and_redirect @user, event: :authentication
 				return
 			end

 			# Guardar la información que tenemos de Devise
 			session["devise.auth"] = request.env["omniauth.auth"]

 			render :edit
 		end

 		def custom_sign_up
 			@user = User.from_omniauth(session["devise.auth"])
 			if @user.update(user_params)
 				# Autenticando al usuario y redireccionarlo al home
 				sign_in_and_redirect @user, event: :authentication
 			else
 				render :edit
 			end

=begin
			update({}) Actualizar
			new({}) Instanciar
			create({}) Instanciar y guardar

			params --- Hash {id: "",email:"",...}
=end
 		end

 		def failure
 			redirect_to new_user_session_path, notice: "No se puedo hacer el login. Error #{params[:error_description]}. Motivo: #{params[:error_reason]}"
 		end

 		private
 			def user_params
 				# Strong Params
 				params.require(:user).permit(:name,:username,:email)
 			end
 	end