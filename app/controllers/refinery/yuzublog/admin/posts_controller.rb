module Refinery
  module Yuzublog
    module Admin
      class PostsController < ::Admin::BaseController
        crudify :'post',
          :order => 'created_on DESC',
          #:redirect_to_url =>:redirect_to_where?
          :xhr_paging => true

      end
    end
  end
end