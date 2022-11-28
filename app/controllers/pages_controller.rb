class PagesController < ApplicationController
  def home
    @aircrafts = Aircraft.all.sample(12)
  end
end
