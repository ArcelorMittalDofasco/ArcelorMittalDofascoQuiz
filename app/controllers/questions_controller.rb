class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    
    respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @questions, :include => [:answers] }
    end
  end
end
