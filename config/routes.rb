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
    invitations: 'users/invitations',
    passwords: 'users/passwords'
  }, path_names: {
    sign_in: 'sign-in',
    sign_out: 'sign-out',
    sign_up: 'sign-up'
  }

  resource(:settings, only: %w(edit update))

  resources(:tokens, only: %w(index new create destroy))

  resources(:users, only: %w(index))

  namespace(:users) do
    namespace(:invitations) do
      resources(:instructions, only: %w(index))
    end

    namespace(:passwords) do
      resources(:instructions, only: %w(index))
    end
  end

  resources(:websites) do
    scope(module: :websites) do
      namespace(:charts) do
        resources(:response_time, only: %w(index), path: 'response-time')
      end
    end
  end
end
