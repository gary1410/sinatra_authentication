enable :sessions

get '/' do
    if session[:user_id]
      @current_user = User.find(session[:user_id])
      @users = User.all
      erb :index
    else
      erb :index
    end
end

#----------- SESSIONS -----------

get '/sessions/new' do
  session[:user_id]
  erb :sign_in
end

post '/sessions' do
  @user = User.find_by_email(params[:email])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect '/'
    else
      redirect '/users/new'
    end
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
end

#----------- USERS -----------

get '/users/new' do
  # current_user
  erb :sign_up
end

post '/users' do
  user = User.new(params[:user])
  user.save
  if user.save
    p "successfully saved a user"
    redirect '/'
  else
    erb :users
  end
end

