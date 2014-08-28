base_url = "http://#{request.host_with_port}"
xml.instruct!
xml.urlset("xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9", 'xmlns:image'.to_sym => "http://www.google.com/schemas/sitemap-image/1.1") do

  xml.url do
    xml.loc "#{base_url}"
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  @posts.each do |post|
    xml.url do
      xml.loc blog_url(post)
      xml.lastmod post.updated_at.to_date
      xml.changefreq "always"
      xml.priority 0.9
    end
  end

  @categories.each do |category|
    xml.url do
      xml.loc category_url(category)
      xml.lastmod category.updated_at.to_date
      xml.priority 0.9
    end
  end

end