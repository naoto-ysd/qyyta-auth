Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # mount_devise_token_auth_for 'User', at: 'auth'
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: "api/v1/auth/registrations",
        sessions: "api/v1/auth/sessions"
      }

      resources :users
    end

  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
