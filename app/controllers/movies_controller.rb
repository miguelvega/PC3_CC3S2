class MoviesController < ApplicationController

  helper_method :sort_column, :sort_direction, :toggle_direction, :hash_ratings
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    @ratings_to_show = params[:ratings] || @all_ratings
    @ratings_to_show = @ratings_to_show.keys if @ratings_to_show.is_a?(Hash)
    @movies = Movie.with_ratings(@ratings_to_show)
    
    if params[:sort].present?
      column_select = sort_column
      direction_select = params[:direction]
      @movies = @movies.order("#{column_select} #{direction_select}")
      set_style_header column_select
    end

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  private 

  def set_style_header sort_column
    @title_header_class='hilite bg-warning' if sort_column == 'title'
    @release_date_header_class='hilite bg-warning' if sort_column == 'release_date'
  end

  def sort_column
    Movie.column_names.include?(params[:sort]) ? params[:sort] : ''
  end

  def toggle_direction(column)
    session["sort_direction_#{column}"] = (session["sort_direction_#{column}"] == 'asc') ? 'desc' : 'asc'
  end

  def hash_ratings(ratings_keys) 
    Hash[ratings_keys.map{|ratings_key| [ratings_key,'1']}]
  end
end