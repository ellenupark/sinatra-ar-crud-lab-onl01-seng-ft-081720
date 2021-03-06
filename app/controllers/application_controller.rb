
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # get '/' do
  #   erb :index
  # end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    new_article = Article.new(params)
		if new_article.save
			redirect "/articles/#{new_article.id}"
		else
			redirect '/articles/new'
		end
  end

  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
		@article = Article.find_by_id(params[:id])
		params.delete("_method")
		
		if @article.update(params)
			redirect "/articles/#{@article.id}"
		else
			redirect "articles/new"
    end
  end

  delete '/articles/:id' do
    @article = Article.find_by_id(params[:id])
		@article.destroy
		redirect "/articles"
  end

end
