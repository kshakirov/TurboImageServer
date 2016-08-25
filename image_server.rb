require 'sinatra'
require "sinatra/activerecord"
require 'uri'
require 'mini_magick'
require 'active_support/all'
require_relative 'lib/src/sync'

set :bind, '0.0.0.0'
set :port, 4570
set :images_collection, ENV['METADATA_IMAGES_COLLECTION']

configure do
  set :image_syncer, ImageSync.new(ENV['METADATA_IMAGES_COLLECTION'])
  set :image_processor, ImageProcessor.new
end

before do
  headers 'Content-Type' => 'image/jpeg'
end


get '/part/:partname/product/:sku/image/:resolution' do
    content_type 'image/jpeg'
    image_name = settings.image_syncer.get_image(params[:partname], params[:sku], params[:resolution])
    settings.image_processor.run image_name
end

get '/part/:partname/product/image/:resolution' do
  content_type 'image/jpeg'
  send_file(settings.image_syncer.get_image(params[:partname], params[:sku], params[:resolution]), :filename => 'image', :type => 'image/jpeg')
end

get '/product/:sku/image_gallary/:resolution' do
  content_type 'image/jpeg'
  settings.image_syncer.get_images_list params[:sku], params[:resolution]
end

get '/product/:sku/resolution/:resolution/image/:id' do
  content_type 'image/jpeg'
  image = settings.image_syncer.get_image_file params[:sku], params[:resolution], params[:id]
  send_file(image, :filename => image, :type => 'image/jpeg')
end


not_found do
  send_file(settings.image_syncer.get_default_image params[:partname])
end


get '*' do
  'uknown route'
end