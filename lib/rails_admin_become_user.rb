require "rails_admin_become_user/engine"

module RailsAdminBecomeUser
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class BecomeUser < Base
        RailsAdmin::Config::Actions.register(self)
        
        register_instance_option :member do
          true
        end

        # By default, show for all Devise models
        register_instance_option :visible? do
          bindings[:object].respond_to?(:devise_modules) && authorized?
        end

		# Sign in as the Device model and go to the default page for that model.
		# See Devise after_sign_in_path_for for more details
        register_instance_option :controller do
          proc do
            begin
              flash[:notice] = wording_for(:message)
              sign_in_and_redirect(@object, @object, :bypass => true)
            rescue ActionController::UrlGenerationError
              redirect_to :back, :alert => wording_for(:error_no_route)
            end
          end
        end

        register_instance_option :link_icon do
          'icon-user'
        end

        register_instance_option :pjax? do
          false
        end
      end
    end
  end
end
