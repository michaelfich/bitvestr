class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_formulas
    formulas = Formula.ordered
    formulas = formulas.map do |formula|
      [ formula.abbreviation, formula.name ]
    end
  end
end
