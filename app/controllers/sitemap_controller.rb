class SitemapController < ApplicationController
  def index
  	@posts = Article.where(published: 1)
  	@categories = Category.all
  	@base_url = "http://#{request.host_with_port}"
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
        format.html
        format.xml
    end
  end
end
