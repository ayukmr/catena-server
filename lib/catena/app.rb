module Catena
  # sinatra app
  class App < Sinatra::Base
    # set content type
    set :default_content_type, :json

    # cross origin resource sharing
    before do
      headers['Access-Control-Allow-Origin']  = '*'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, PATCH, DELETE, OPTIONS'
    end

    # options for all routes
    options '*' do
      response.headers['Allow'] = 'HEAD, GET, POST, PUT, PATCH, DELETE, OPTIONS'
      response.headers['Access-Control-Allow-Headers'] =
        'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept, Authorization'
    end

    # get list of items
    get '/items/:type/:category' do |type, category|
      halt 401 unless request.env['HTTP_AUTHORIZATION']

      # slice header
      token = request.env['HTTP_AUTHORIZATION']
      token.slice!('Bearer ')

      # get items
      HTTParty.get(
        "https://nuevaschool.myschoolapp.com/api/#{type}/forresourceboard",
        {
          query: {
            format: 'json',
            categoryId: category,
            t: token
          }
        }
      ).body
    end

    # get item detail
    get '/detail/:id' do |id|
      halt 401 unless request.env['HTTP_AUTHORIZATION']

      # slice header
      token = request.env['HTTP_AUTHORIZATION']
      token.slice!('Bearer ')

      # get detail
      HTTParty.get(
        "https://nuevaschool.myschoolapp.com/api/news/detail/#{id}",
        {
          query: {
            format: 'json',
            t: token
          }
        }
      ).body
    end
  end
end
