class ArticlesController < ApplicationController

	http_basic_authenticate_with name: "richard", password: "123456", except: [:index, :show]

	def index
		#Get all the articles from the Article class model and put it into an instance variable array
		#Article.all is the model command to get all the articles from the database
		#@articles is an instance variable which can be accessed in the view
		@articles = Article.all
	end

	def new
		#Article.new is to create a row of data which later can be saved
		#this to instantiate the article to prevent nil when error checking is performed
		@article = Article.new
	end

	def create
		#Article.new get the parameters not directly from the batch params, but it has to go through filter to prevent security risk
		@article = Article.new(article_params)
		#this is to do validate the input. @article.save will result in boolean
		if @article.save
			#redirect to show article
			redirect_to @article
		else
			#redirect to new article page but it uses render to preserve the input values
			render 'new'
		end		
	end

	def show
		#this is to show the saved article contents
		#this call the parameter of the article which just saved
		@article = Article.find(params[:id])
	end

	def edit 
		@article = Article.find(params[:id])
	end

	def update
		#get the articles to edit		
		@article = Article.find(params[:id])

		if @article.update(article_params)
			#when the update is successful, it redirect to show the finalized article
			redirect_to @article
		else
			#go back to edit screen and render to prevent another browser request.
			render 'edit'
		end

	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path
	end

	private
	def article_params
		params.require(:article).permit(:title, :text)
	end

end
