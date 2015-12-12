class UserAnswersController < ApplicationController
  def new
    @user = User.new
    @user_answer = UserAnswer.new
    @questions = Question.all
  end
  
  def show
    respond_with(@user)
  end
  
  def create
    @user = User.new(user_params)
    #@user_answers = UserAnswer.new
    params[:user_answers].map do |key, val|
      hash = {}
      hash[:question_id] = val[:question]
      hash[:answer_id] = val[:answer]
      #hash[:user_id] = @user.id
      @user.user_answers.build(hash)
    end
    
    
    respond_to do |format|
      if @user.save
        format.html { }
        format.json { render :json => @user}
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors }
      end
    end
    
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email)
  end
  
  def user_answer_params
    params.require(:user_answers).permit([:question, :answer])
  end
  
end
