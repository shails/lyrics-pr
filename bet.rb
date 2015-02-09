require 'sinatra'
require 'sinatra/reloader' if development?

get '/bet/:stake/on/:num' do
	bet = params[:stake].to_i
	number  = params[:num].to_i
	roll = rand(7)+1
	if roll!= number
		 "You have lost the bet of #{bet} on number #{number}"
	else
		 "You have won the bet and made #{bet*7}"
	end
end