module Refinery
  module Yuzublog
    module Admin
      class CommentsController < ::Admin::BaseController
        crudify :'comment',
          :order => 'created_on DESC',
          #:redirect_to_url =>:redirect_to_where?
          :xhr_paging => true

      end
    end
  end
end