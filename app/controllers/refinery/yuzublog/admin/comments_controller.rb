module Refinery
  module Yuzublog
    module Admin
      class CommentsController < ::Admin::BaseController
        unloadable

        crudify :'comment',
          :order => 'created_on DESC',
          :xhr_paging => true

        #before_filter :set_active_user, :only=>[:create, :update]
        before_filter :determine_scope

        protected

        def determine_scope

        end

        def find_all_comments
          if params['blog_id']
            @blog=Blog.find(params['blog_id'])
            @comments=@blog.post_comments
          end

        end

        public
      end
    end
  end
end