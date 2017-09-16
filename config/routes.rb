Rails.application.routes.draw do
  devise_scope :user do
    authenticated do
      root to: 'websites#index', as: :authenticated_root
    end
  end

  root to: 'welcome#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    invitations: 'users/invitations'
  }, path_names: {
    sign_in: 'sign-in',
    sign_out: 'sign-out',
    sign_up: 'sign-up'
  }

  resource(:settings, only: %w(edit update))
  resources(:users, only: %w(index))
  resources(:websites, only: %w(index new create show edit)) do
    scope(module: :websites) do
      namespace(:charts) do
        resources(:response_time, only: %w(index), path: 'response-time')
      end
    end
  end

  namespace(:users) do
    namespace(:invitations) do
      resources(:instructions, only: %w(index))
    end
  end
end
