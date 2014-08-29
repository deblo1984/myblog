class Admin::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.order("created_at DESC").page(params[:page]).per(5)
    #@articles = Article.published(params[:publish]).order("created_at DESC").page(params[:page]).per(10)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    #@article = Article.new(article_params)
    @article = current_user.articles.build(article_params)
    #@article.user = current_user 
    if params[:publish]  
        @article.published = '1'
    else
        @article.published = '0'
    end
    respond_to do |format|
      if @article.save 
        format.html { redirect_to ([:admin,@article]), notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: ([:admin,@article]) }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    if params[:publish]  
        @article.published = '1'
    else
        @article.published = '0'
    end
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to ([:admin,@article]), notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def browse
    if params[:published] == 'publish'
      params[:published] = '1'
    else
      params[:published] ='0'
    end
    @articles = Article.published(params[:published]).order("created_at DESC").page(params[:page]).per(10)
    render :action => :index
  end

  def autocomplete_tags
    @tags = ActsAsTaggableOn::Tag.
      where("name LIKE ?", "#{params[:q]}%").
      order(:name)
    respond_to do |format|
       format.json { render :json => @tags.collect{|t| {:id => t.name, :name => t.name }}}
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :keyword, :description, :body, :image_url, :category_id, :tag_list)
    end
end
