class Admin::DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  	@posts = Article.all.order('created_at DESC').limit(10)
  	@categories = Category.all.order('created_at DESC').limit(10)
  end
end
