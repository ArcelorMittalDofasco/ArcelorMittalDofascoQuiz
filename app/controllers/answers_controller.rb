class AnswersController < ApplicationController
  def index
    @answers = Question.find(params[:question_id]).answers
    
    respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @answers }
    end
  end
end
