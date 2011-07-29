::Refinery::Application.routes.draw do
  scope(:path => 'refinery/yuzublog', :as => 'refinery_admin', :module => 'refinery/yuzublog/admin') do
    resources :blogs, :except => :show  do
      resources :posts do
        collection do
          get 'drafts'
        end
      end
    end
    resources :posts, :except=> [:show, :new]
    resources :comments, :except => :show
  end
end
