class Strategy::CollaborationsController < ApplicationController
  def index
    @pending = Collaboration.pending(current_user).order(id: :asc)
    @strategies = Collaboration.approved(current_user).map do |collaboration|
      collaboration.strategy
    end
  end

  def create
    email = user_params[:user]

    @user = User.where(email: email).first
    @strategy = strategy

    collaboration = Collaboration.new(collaboration_params)
    collaboration.strategy = @strategy

    errors = []
    if @user.nil?
      errors << "#{email} is not a valid user"
    elsif @user == current_user
      errors << "You cannot add yourself as a collaborator"
    elsif Collaboration.approved?(@strategy, @user).any?
      errors << "#{@user.full_name} is already a collaborator on this trading strategy"
    elsif Collaboration.pending?(@strategy, @user).any?
      errors << "#{@user.full_name} has already been sent an invitation to collaborate on this strategy"
    else
      collaboration.user = @user
    end

    if errors.empty?
      collaboration.save
      render json: { success: true, confirm: ["Sent an invitation to #{@user.email} to collaborate on this strategy"] }
    else
      collaboration.errors.clear
      errors.each { |error| collaboration.errors.add(:base, error) }
      render json: { success: false, errors: collaboration.errors.full_messages }
    end
  end

  def update
    collaboration = Collaboration.find(params[:id])
    collaboration.update_attributes(collaboration_params)
    redirect_to strategy_collaborations_url
  end

  def destroy
  end

  private
  def collaboration_params
    params.require(:collaboration).permit(:confirmed, :strategy_id)
  end

  def user_params
    params.require(:collaboration).permit(:user)
  end

  def strategy
    Strategy.find(params[:collaboration][:strategy_id].to_i)
  end
end
