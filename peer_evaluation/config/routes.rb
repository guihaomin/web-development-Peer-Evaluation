Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  get '/users', to: 'static_pages#users'
  get '/login', to: 'static_pages#login'
  get '/register', to: 'static_pages#register'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/writeeva', to: 'users#writeeva'
  get '/instructor', to: 'users#instructor'
  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/delproject', to: 'users#delproject'
  post '/newgroup', to: 'users#newgroup'
  post '/addstudent', to: 'users#addstudents'
  post '/delgroup', to: 'users#delgroup'
  get '/configclass', to: 'users#configclass'
  get '/creategroup', to: 'users#creategroup'
  get '/changegroup', to: 'users#changegroup'
  get '/createproject', to:'users#createproject'
  get '/manage_groups', to:'users#manage_groups'
  get '/manage_projects', to:'users#manage_projects'
  get '/writeevaluation', to:'users#writeevaluation'
  get '/destroy', to:'users#destroy'
  post '/completeevaluation', to:'users#completeevaluation'
  post '/new_project', to:'users#new_project'
  post '/completechange', to: 'users#completechange'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end
