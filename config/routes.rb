Rails.application.routes.draw do
  resources :suggestions
  get 'home/index'
  get 'home/dashboard'
  get 'home/checkoutpage'
  get 'suggestions/received' => 'suggestions#received', as: 'received_suggestion'
  get 'suggestions/approve/:id' => 'suggestions#approve', as: 'approve_suggestion'
  get 'reservations/history' => 'reservations#user_history', as: 'user_history_reservation'
  get 'reservations/checkout' => 'reservations#checkout_reservation', as: 'checkout_reservation'
  get 'reservations/checkin' => 'reservations#checkin_reservation', as: 'checkin_reservation'
  get 'reservations/cancel' => 'reservations#cancel_reservation', as: 'cancel_reservation'
 # get 'reservations/new_for_user/' => 'reservations#new_for_user', as: 'new_reservation_for_user'
 # get 'reservations/create_for_user' => 'reservations#create_for_user', as: 'create_reservation_for_user'

  resources :reservations
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'registrations'
		
      }
      devise_scope :user do
      	get "users/display", to: "registrations#display", as: "user_display"
        get "user/new1", to: "registrations#new1", as: "user_new1"
        get "user/edituser", to: "registrations#edituser", as: "edituser"
        post "user/create_user", to: "registrations#create_user", as: "create_new_user"
        get "user/show", to: "registrations#show", as: "showuser"
      end

  resources :cars
  get 'cars/:id/notify' => 'cars#notify_availability', as: 'notify_availability'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
