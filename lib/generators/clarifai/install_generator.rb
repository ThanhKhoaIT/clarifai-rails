require "rails/generators/base"

module Clarifai
  module Generators

    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def copy_initialize
        template "clarifai.rb", "config/initializers/clarifai.rb"
      end

    end

  end
end
