Rails.application.routes.draw do
  # resources :employee_reports, except: [:new, :edit]
  scope :api, defaults: { format: 'json' } do
    ############################# Return Rates ################################
    resources :employee_daily_attendances, except: [:new, :edit, :create, :update, :destroy, :show, :index] do
      collection do
        get :daily_attendances
      end
    end
  end
end