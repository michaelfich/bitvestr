class Formula < ActiveRecord::Base
  def self.ordered
    order(order_number: :asc)
  end

  def self.display(short)
    @formulaArr ||= self.ordered
    result = @formulaArr.find do |formula|
      formula.name == short
    end
    result.full_name
  end
end
