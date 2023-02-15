# frozen_string_literal: true

module Users
  class DiscoverController < ApplicationController
    before_action :current_user, only: :index

    def index; end
  end
end
