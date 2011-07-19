::Refinery::Application.routes.draw do
  scope(:path => 'refinery/yuzublog', :as => 'refinery_admin', :module => 'refinery/yuzublog/admin') do
    resources :blogs, :except => :show do
    #  resources :posts, :except => :show
    end
    resources :posts, :except=> :show
    resources :comments, :except => :show
  end
end
