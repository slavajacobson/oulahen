json.array!(@slide_show_images) do |slide_show_image|
  json.extract! slide_show_image, :image, :description
  json.url slide_show_image_url(slide_show_image, format: :json)
end
