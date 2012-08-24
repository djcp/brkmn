Brkmn::Application.routes.draw do
  resources :urls do
    collection do
      get 'url_list'
      get 'bookmarklet'
    end
  end
  root :to => 'urls#index'

  # So anything that doesn't match the resource controllers or the root path goes to the redirector controller.

  match '/redirector/invalid' => 'redirector#invalid'

  resources :passwords, :controller => 'clearance/passwords',
    :only => [:create, :new]

  resource  :session, :controller => 'clearance/sessions',
    :only => [:create, :new, :destroy]

  resources :users, :controller => 'clearance/users', :only => [:create, :new] do
    resource :password, :controller => 'clearance/passwords',
      :only => [:create, :edit, :update]
  end

  match 'sign_in' => 'clearance/sessions#new', :as => 'sign_in'
  match 'sign_out' => 'clearance/sessions#destroy', :as => 'sign_out', :via => :delete
  match 'sign_up' => 'clearance/users#new', :as => 'sign_up'

  match '/:id' => 'redirector#index', :as => :shortened
end
