require 'sinatra'
require 'sinatra/reloader' if development?

get '/hello' do
	"hello sinatra!"
end

get '/frank' do
	name ="Frank"
"Hello #{name}"
end

get '/:name' do
	name = params[:name]
	"Hi there #{name}!"
end

get '/:one/:two/:three' do
	"first: #{params[:one]}, second: #{params[:two]}, three: #{params[:three]}"
end

get '/what/time/is/it/in/:number/hours' do
	number = params[:number].to_i
	time = Time.now + number*3600
	"The time in #{number} hours will be #{time.strftime('%I:%M %p')}"
end

get '/:number/hours' do
	 hr = params[:number].to_i
	time = Time.now+hr*3600
  "The #{hr}hr time would be #{time.strftime('%I:%M %p')}"
end
	




















