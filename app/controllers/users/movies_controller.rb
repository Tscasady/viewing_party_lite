# frozen_string_literal: true

module Users
  class MoviesController < ApplicationController
    before_action :current_user, only: [:index, :show]
    def index
      @search_term = params[:title_search]

      @movies = if @search_term
                  MovieFacade.new.search_movies(@search_term)
                else
                  MovieFacade.new.get_top_movies
                end
    end

    def show
      @movie = MovieFacade.new(params[:id]).movie
    end
  end
end
