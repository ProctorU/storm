Rails.application.routes.draw do
  devise_scope :user do
    authenticated do
      # root to: 'organizations#index', as: :authenticated_root
    end
  end

  root to: 'welcome#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, path_names: {
    sign_in: 'sign-in',
    sign_out: 'sign-out',
    sign_up: 'sign-up'
  }
end
