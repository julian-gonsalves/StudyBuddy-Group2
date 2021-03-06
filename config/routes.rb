Rails.application.routes.draw do
  get 'notifications/index'
  root 'home#index'
  devise_for :users, controllers: { registrations: "registrations" }
  get 'dashboard/index'
  #Below line to map /dashboard to /dashboard/index
  get "/dashboard" => "dashboard#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :courses do
    resources :study_groups do
      collection do
        post 'attend'
      end
      collection do
        post 'unattend'
      end
      collection do
        post 'unattend_from_dash'
      end
    end
    resources :tutors do
      collection do
        post 'hire'
        post 'complete'
      end
    end
    resources :notes do
      resources :comments do
        collection do
          post 'add'
        end
      end
      collection do
        post 'add'
      end
      collection do
        post 'deleteComment'
      end
    end
    collection do
      post 'add'
      post 'delete_enrolment'
    end
  end
  
  resources :users

  resources :notifications, only: [:index] do
    collection do
      post 'mark_read'
    end
  end

  get 'study_groups/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  
  resources :charges, only: [:new, :create, :show] do
    collection do
      get 'checkout'
    end
  end

end
