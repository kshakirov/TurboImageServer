require 'sinatra'
require "sinatra/activerecord"
require 'uri'
require 'active_support/all'
require_relative 'lib/src/sync'

set :bind, '0.0.0.0'
set :port, 4570
set :images_collection, ENV['METADATA_IMAGES_COLLECTION']

configure do
  set :image_syncer, ImageSync.new(ENV['METADATA_IMAGES_COLLECTION'])
end


get '/part/:partname/product/:sku/image/:resolution' do
    send_file(settings.image_syncer.get_image(params[:partname], params[:sku], params[:resolution]), :filename => 'image', :type => 'Application/octet-stream')
end

get '/part/:partname/product/image/:resolution' do
  send_file(settings.image_syncer.get_image(params[:partname], params[:sku], params[:resolution]), :filename => 'image', :type => 'Application/octet-stream')
end

get '/product/:sku/image_gallary/:resolution' do
  settings.image_syncer.get_images_list params[:sku], params[:resolution]
end

get '/product/:sku/resolution/:resolution/image/:id' do
  image = settings.image_syncer.get_image_file params[:sku], params[:resolution], params[:id]
  send_file(image, :filename => image, :type => 'Application/octet-stream')
end


not_found do
  send_file(settings.image_syncer.get_default_image params[:partname])
end


get '*' do
  'uknown route'
end