class MoviesController < ApplicationController

  helper_method :sort_column, :sort_direction
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
      @movies = @movies.order("#{sort_column} #{sort_direction}")
      
      (@title_header_class='hilite' && @btn_Movie='bg-warning') if sort_column == 'title'
      (@release_date_header_class='hilite' && @btn_ReleaseDate='bg-warning') if sort_column == 'release_date'
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

  def sort_column
    Movie.column_names.include?(params[:sort]) ? params[:sort] : 'title'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
