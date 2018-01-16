class SingersController < ApplicationController
  def index
    browse
  end
  
  def show
  end
  
  def browse
    @letter = params[:letter]
    if @letter.nil?
      @letter = 'A'
    end
    @singers = Singer.find_by_first_letter_of_name(@letter)
    respond_to do |f|
      f.html { render :action => "index" }
      f.js
    end
  end
  
  def search
    @singers = Singer.search do
      keywords params[:query]
    end.results

    respond_to do |f|
      f.html { render :action => "index" }
      f.js
    end
  end
end
