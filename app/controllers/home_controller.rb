class HomeController < ApplicationController
	before_action :set_post, only: [:show]

	layout "home"
	
	def index
		@posts = Article.published(1).order("created_at DESC").page(params[:page]).per(10)
		@recents = Article.recent(10)
	end

	def show
    #add breadcrumb links
    add_breadcrumb "my", :post_path
		@recents = Article.recent(10)
    #@comments = @post.comments.build
	end


	def tagged
  		if params[:tag].present? 
    		@posts = Article.where(published: 1).tagged_with(params[:tag]).page(params[:page]).per(10)
  		else 
    		@posts = Article.all
  		end
  		@recents = Article.recent(10)
  		render :action => "index"
  	end  

  	def sitemap
  		@posts = Article.where(published: 1)
  		@categories = Category.all
  		@base_url = "http://#{request.host_with_port}"
    	headers['Content-Type'] = 'application/xml'
      	respond_to do |format|
        	format.html
        	format.xml
      	end
    end

  	def by_category
  		@category = Category.friendly.find(params[:id])
  		@post = Article.find_by category_id: category.id
  	end

	private
		def set_post
			@post = Article.friendly.find(params[:id])
		end

end
