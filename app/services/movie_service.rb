# frozen_string_literal: true

class MovieService
  def initialize(url = '')
    @url = url
  end

  def get_top_movies
    response = service.get('/3/movie/top_rated')
    parse(response)
  end

  def search_movies(search_query)
    response = service.get('/3/search/movie') do |request|
      request.params['query'] = search_query
    end
    parse(response)
  end

  def movie
    get_basic_movie_info.merge(get_cast).merge(get_reviews)
  end

  private

  def base_uri
    'https://api.themoviedb.org'
  end

  def service
    Faraday.new(service_params)
  end

  def service_params
    {
      url: base_uri,
      params: { api_key: ENV['moviedb_key'] }
    }
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_basic_movie_info
    parse(service.get("/3/movie/#{@url}"))
  end

  def get_cast
    parse(service.get("/3/movie/#{@url}/credits"))
  end

  def get_reviews
    parse(service.get("/3/movie/#{@url}/reviews"))
  end
end
