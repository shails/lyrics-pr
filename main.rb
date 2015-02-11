require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/flash'
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
before do
	set_title
end

helpers do
def css(*stylesheets)
	stylesheets.map do |stylesheet|
		"<link href=\"css/#{stylesheet}.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
	end.join
end
def mcss(*stylesheets)
	stylesheets.map do |stylesheet|
		"<link href=\"css/#{stylesheet}.min.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
	end.join
end
def active?(path='/')
	(request.path==path || request.path==path+'/') ? "active" : nil
	end
	def set_title
		@title ||= "Songs By Sinatra"
	end
end

get '/login' do
	erb :login
end

get '/' do 
	@title = 'Home'
	erb :home

end

get '/about' do
	@title='About'
	erb :about
end
get '/contact' do
	@title='Contact'
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