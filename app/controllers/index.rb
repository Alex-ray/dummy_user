enable :sessions

get '/' do
  @access = params[:access]
  erb :index
end

post '/login' do 

# "#{params[:user_name], params[:password]}"
end

get '/login' do 

  erb :login
end

get '/signup' do 
  @valid = params[:valid]
  erb :signup
end

post '/signup' do 
  @user_name = params[:user_name]
  @password = params[:password]
  @email = params[:email]
  if User.create({user_name: @user_name, email: @email, password: @password}).valid?
    session[:user] = @user_name
    redirect to "/#{@user_name}"
  else
    redirect to "/signup?valid=false"
  end 
end

get '/:user_name' do
  @session = session[:user] 
  if @session == params[:user_name]
    @user_name = @session
    erb :logged_in
  else
    redirect to '/?access=denied'
  end
end
