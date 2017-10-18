class QuestionsController < ApplicationController
  # all public methods in controllers are referred to as actions
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, except:[:index, :show, :new, :create]
  before_action :authenticate_user!, except:[:show, :index]
  
  # before_action is executed in the order that they appear. Make sure that any action that is dependent on another action appears after the action
  # upon which it depends.

  def new
    # using the render method is not necessary if there is a view in 'views/questions'
    # with the same name as the action 'new'
    @question = Question.new

  end

  def create
    # rendern json: params
    # return
    # use render with json for debugging purposes
    
    @question = Question.new(question_params)
    @question.user = current_user

    if(@question.save)
      redirect_to question_path(@question)
      # redirect_to @question 👈
    else
      render :new #render can take a symbol as an argument which should be named after a template.
      # it'll render the template for that action instead
    end
  end

  def show
    # @question= Question.find(params[:id])
    # We abstracted this step out of the 'show', 'edit', 'destroy', 'update' and made a method at the bottom of the 
    # page to do this task--- then we called 'before action' at the top of the page
      @answer = Answer.new
      @answers = @question.answers.order(created_at: :desc)
  end

  def index
    @questions = Question.order(created_at: :desc)
    
  end

  def edit

  end

  

  def update
    return head :unauthorized unless can?(:update, @question)
    if @question.update question_params
      redirect_to @question
    else
      render :edit 
    end
  end

  def destroy

    @question.destroy
    redirect_to questions_path
  end

  

  private
  def question_params
    # With this method we will extract the parameters related to  question from 
    # the 'params' object. And, we'll only permit certain fields of our choice.
    # In this case, we specifically restrict the params to the user imput :title, and :body
    params.require(:question).permit(:title, :body)
    # The 'params' object is availbale inside all controllers. It's an object that looks like a 
    # 'hash' that holds all URL params, all fields from the form, and all query params. It's
    # as if we merged 'request.query', 'request.params', and 'request.body' from Express
    # into one object. 
  end 

  def find_question
    @question= Question.find(params[:id])
  end

  # Remember that if a 'before_action' callback does a 'render', 'redirect_to' or 
  # 'head' (methods that terminate the response), it will stop the requestion from getting to the action.

  def authorize_user!
    
    unless can?(:manage, @question)
      flash[:alert] = "Access denied!"
      redirect_to root_path
    end
  end
  # 'head' is a method similar to 'render' or 'redirect_to',. It finalizeds the response. However, it will not add content to the response. 
  # It will simply set the HTTP status of the response. (e.g. head :unauthorized sets the status code to 401)
  # see here for a list of status codes: http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
end
