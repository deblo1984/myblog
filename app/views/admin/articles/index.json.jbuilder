json.array!(@articles) do |article|
  json.extract! article, :id, :title, :description, :body, :image_url, :published
  json.url article_url(article, format: :json)
end
