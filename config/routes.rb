Rails.application.routes.draw do
  
  namespace :admin do
    #  The 'namespace' routing method will ad the first argument as a prefix to all routes to
    #  all routes defined inside its block. In this case, it will add '/admin' 
    # making the url for dashboard equal to '/admin/dashboard'
    # Rails will expect that the namespacesd controller will be in a directory named
    # after the first argumen adn a module of the same name.

    # with namespace, the following route will give us the url:
    #   '/admin/dashboard'
    resources :dashboard, only: [:index]
  end
  # Note that we are not using the plural form of 'resources'. We are using 'resource', which will not generate routes 
  # routes that require an 'id'. Instead 'resource' expects that our controller actions will always
  # operate on the same resource.
  # Even though 'resource :session' is written with a singular ':session', the controller
  # must still be plural!! 'SessionsController'
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  # get('questions/new', {to: 'questions#new', as: :new_question})
  # post('questions', {to:'questions#create', as: :questions})
  # get('questions/:id', {to: 'questions#show', as: :question})
  # patch('/questions/:id', to: 'questions#update')
  # delete('/questions/:id', {to: 'questions#destroy'})
  # # When creating a route with a matched parameter (e.g. :id, :name, etc)
  # # you must provide that parameter as an argument to the generated method.
  # # (e.g. question_path(question.id), question_path(question), question_path(2))
  # get('questions', {to: 'questions#index'})
  # # when we receive an HTTP GET request with URL: /hello
  # # send this request to the WelcomeController and invoke the 'hello' method
  # # within that controller
   get('/hello', {to: 'welcome#hello', as: :hello})
   get('/subscribe', {to: 'subscriptions#new', as: :subscribe})
   post('/subscribe', {to: 'subscriptions#create'})
   get('/questions/:id/edit', {to: 'questions#edit', as: :edit_question})

  resources :questions do
    # Use 'shallow: true' option to remove nesting for paths that do not normally require
    # information from the parent resourse(e.g. show,edit, destroy, update)
    # DELETE /question/:question_id/answers/:answer_id
    # becomes DELETE /answers/:id

    resources :answers, shallow: true, only: [:create, :destroy]
  end



  # 'resources' method will generate all conventional CRUD routes for a name at once.
  # 'resources :questions' will generate exactly the same rutes we wrote manually above.


  root('welcome#index')
  # same as:
  # get('/', {to: 'welcome#index'})
  # often this is written as:
  # get '/', to 'welcome#index'
  # or
  # get '/' => 'welcome#index'
end
