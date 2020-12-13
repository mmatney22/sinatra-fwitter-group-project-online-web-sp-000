
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    @user = current_user if is_logged_in? 

    erb :index
  end 

  get '/signup' do 
 
      if Helpers.is_logged_in?(session) 
        redirect '/tweets'
      else 
        erb :'/users/signup' 
      end 
    end 
  
    post '/signup' do
      user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = user.id
  
      if user.save && user.username != "" && user.email !="" && user.password !=""
              redirect "/tweets"
          else
              redirect "/signup"
          end
  
    end
    

  

end