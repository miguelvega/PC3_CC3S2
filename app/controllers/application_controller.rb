class ApplicationController < ActionController::Base
  helper_method :sort_column, :sort_direction, :sort_column_class
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private

  def sort_column_class(column)
    return 'hilite' if sort_column == column

    ''
  end
  
  def sort_direction(column)
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
