module SpreeSlider
  class InstallCycle2Generator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)    
    def install
      #copy slider partial
      copy_file "cycle2_slider.html.erb", "app/views/spree/shared/_slider.html.erb"

      #add javascripts
      append_file "vendor/assets/javascripts/spree/frontend/all.js", "//= require js/jquery.cycle2\n"

      #add stylesheets
      inject_into_file "vendor/assets/stylesheets/spree/frontend/all.css", " *= require css/cycle2\n", before: /\*\//, verbose: true
      inject_into_file "vendor/assets/stylesheets/spree/backend/all.css", " *= require css/slider\n", before: /\*\//, verbose: true

      #copy migrations
      run 'bundle exec rake railties:install:migrations FROM=spree_slider'

      #run migrations
      res = ask "Would you like to run the migrations now? [Y/n]"
      if res == "" || res.downcase == "y"
        run 'bundle exec rake db:migrate'
      else
        puts "Skiping rake db:migrate, don't forget to run it!"
      end

    end
  end
end

