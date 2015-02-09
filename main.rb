require 'sinatra'
require 'sinatra/reloader' if development?
require 'sass'
require './song'
get('/css/custom.css'){ scss :custom }

configure :development do
	DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end
configure :production do
	DataMapper.setup(:default, ENV['DATABASE_URL'])
end

configure do
	enable :sessions
	set :username, 'frank'
	set :password, '1234'
end

get '/login' do
	erb :login
end

get '/' do 
	@title = 'Song by Sinatra'
	erb :home

end

get '/about' do
	@title='about'
	erb :about
end
get '/contact' do
	@title='contact'
	erb :contact
end

not_found do
	erb :not_found
end

post '/login' do
	if params[:username] == settings.username && params[:password] == settings.password
		session[:admin] = true
	    redirect to('/songs')
	else
		erb :login
	end
end
get '/logout' do
	session.clear
	redirect to('/login')
end