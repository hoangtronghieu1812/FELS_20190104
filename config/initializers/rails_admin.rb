  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  require Rails.root.join('lib', 'rails_admin', 'custom_action.rb')
  RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::CustomAction)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  RailsAdmin.config do |config|
    config.parent_controller = "ApplicationController"
    config.included_models = [Course, Word, User, WordAnswer]
    config.label_methods << :content
    config.authorize_with :cancancan
    config.current_user_method(&:current_user)

    config.actions do
      dashboard                     # mandatory
      index do
        except ['WordAnswer']
      end                   # mandatory
      new do
        except ['Word', 'WordAnswer']
      end
      bulk_delete
      show
      edit do
        except ['Word', 'WordAnswer']
      end
      delete
      show_in_app
      new_word
      edit_word
      import_word
      ## With an audit adapter, you can add:
      # history_index
      # history_show
    end
  end
