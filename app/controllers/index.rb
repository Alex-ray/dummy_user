enable :sessions

get '/' do
  @access = params[:access]
  erb :index
end

post '/login' do 
  @email = params[:email]
  @password = params[:password]
  if !authorize(@email, @password)
    redirect to '/login?valid=false'
    session[:user] = nil
  else
    user = User.find_by_email(@email)
    @user_name = user.user_name
    session[:user_name] = @user_name
    redirect to "/#{@user_name}"
  end
end

get '/login' do 
  @valid = params[:valid]
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
  @session = session[:user_name] 
  if @session == params[:user_name]
    @user_name = @session
    erb :logged_in
  else
    redirect to '/?access=denied'
  end
end

def authorize(email, password)
  user = User.find_by_email(email)
  return false if user.nil?
  if user.password == password
    return true
  else
    return false
  end
end