require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      class CustomAction < RailsAdmin::Config::Actions::Base
        register_instance_option :visible? do
          authorized? && bindings[:object].class == Word
        end

        register_instance_option :link_icon do
          'icon-eye-open'
        end

        register_instance_option :pjax? do
          false
        end
      end

      class NewWord < CustomAction
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection do
          true
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :controller do
          Proc.new do
            @word = Word.new
            @word_answers = @word.word_answers.build
            if request.get?
              respond_to do |format|
                format.html {render @action.template_name}
              end
            elsif request.post?
              word_params = params.require(:word).permit :course_id,
                :content,word_answers_attributes: [:id, :content, :correct]
              @word = Word.new word_params
              unless @word.save!
                flash[:danger] = "Word create failed, try again!"
              end
              redirect_to index_path(@model_name)
            end
          end
        end
      end

      class EditWord < CustomAction
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          true
        end

        register_instance_option :http_methods do
          [:get, :post, :patch]
        end

        register_instance_option :controller do
          Proc.new do
            if request.get?
              respond_to do |format|
                format.html {render @action.template_name}
              end
            elsif request.patch?
              word_params = params.require(:word).permit :course_id, :content,
                word_answers_attributes: [:id, :content, :correct, :_destroy]
              unless @object.update word_params
                flash[:danger] = "Word update failed, try again!"
              end
              redirect_to index_path(@model_name)
            end
          end
        end
      end

       class ImportWord < CustomAction
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection do
          true
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :controller do
          Proc.new do
            if request.get?
              respond_to do |format|
                format.html {render @action.template_name}
              end
            elsif request.post?
              Word.import_file(params[:file])
                redirect_to index_path(@model_name), notice: "Words imported."
            end
          end
        end
      end
    end
  end
end
