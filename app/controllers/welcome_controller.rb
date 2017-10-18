# All controller classes in rails end with 'Controller'
# Controllers inherit  (eventually) from ActionController::Base
# All of the built in controller features in rails come from ActionController::Base
# class
# Rails applications come with ApplicationController and by default all
# generated Rails controllers will inherit from ApplicationController which inherits
# from ActionController::Base

class WelcomeController < ApplicationController

  def hello
  end

  def index
  end

  # The method here is called a controller action
  # The convention is that the action will look inside the 'views' folder
  # for a subfolder called 'welcome', then it will look for a view file there
  # named with the action name, which is 'hello' in this case. It will expect it
  #  to have extension 'html.erb' by default. These can be changed to render JSON
  # or some other templating system such as 'rabl'

  # in some cases, you might want to render something other than the default.
  # Let's say that we want to render a template called 'hi' instead of 'hello', in
  # such a case you will have to use the 'render' method as in:
  #  'render('welcome/hi')'

  # By default, all reails actions wil use the layout file:
  # views/layouts/application.html.erb unless you specify something else

end
