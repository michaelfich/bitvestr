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

  def get_intervals
    intervals = [
      ["10 minutes", 1],
      ["20 minutes", 2],
      ["30 minutes", 3],
      ["40 minutes", 4],
      ["50 minutes", 5],
      ["1 hour", 6],
      ["2 hours", 12],
      ["3 hours", 18],
    ]
  end
end
