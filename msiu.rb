

require 'thor'
require 'open-uri'

$repo='https://github.com/aai10/rails4_app_templates/raw/master'

def get_file(path, url)
  file path, open(url).read
end

def get_font(name)
  get_file "vendor/assets/fonts/#{name}", file_url("fonts/#{name}")
end


def file_url(name, base_url=$repo)
  "#{base_url}/files/#{name}"
end


# Баг в Thor. binread всегда считывает US-ASCII
File.instance_eval do
  def binread(file)
    File.open(file, "rb:#{Encoding.default_external.to_s}") { |f| f.read }
  end
end


#Загрузка изображений МГИУ
get_file 'public/favicon.ico', file_url('favicon.ico')
get_file 'app/assets/images/logo.png', file_url('logo.png')


#Имя пользователя и пароль к БД

db_username=ask("Database username:")
db_password=ask("Database password:")

gsub_file 'config/database.yml', /username:.*$/, "username: #{db_username}" if db_username.present?
gsub_file 'config/database.yml', /password:.*$/, "password: #{db_password}" if db_password.present?

#Настройка локали
gem 'rails-i18n'
gsub_file 'config/application.rb', /^.*#.*default_locale\s*=.*$/, '  config.i18n.default_locale = :ru'
get_file 'config/locales/ru.yml', file_url('ru.yml')

#fonts
insert_into_file 'config/application.rb', :before => /\s+end\s+end\s*\z/ do
  "\n    config.assets.paths << \"\#{Rails}/vendor/assets/fonts\"\n
         config.assets.precompile += %w(*.svg *.eot *.woff *.ttf)"
end
  get_font('intro.woff')
  get_font('open_sans.woff')
  %w(bold italic light).each { |x| get_font("open_sans_#{x}.woff") }
  get_font('ubuntu_mono.woff')
  get_font('ubuntu_mono_bold.woff')
  get_font('ubuntu_mono_italic.woff')

  get_file 'vendor/assets/stylesheets/fonts.css.scss', file_url('fonts/fonts.css.scss')


#Установка часового пояса
gsub_file 'config/application.rb', /^.*#.*config.time_zone\s*=.*$/, '  config.time_zone = \'Moscow\''


#Gemfile
add_source 'http://gems.msiu.ru'

gem 'haml-rails'
gem 'therubyracer', :platforms => :ruby
gem 'msiu_userapi'

gem_group :development, :test do
  gem "rspec-rails"
end


#routes
generate('controller', 'welcome', 'index')
route "root 'welcome#index'"

#Twitter Bootstrap
gem 'bootstrap-sass'
run 'bundle install'
gem 'font-awesome-rails'
run 'rm app/views/layouts/application.html.erb'
get_file('app/views/layouts/application.html.haml', file_url('views/application.html.haml'))
get_file('app/views/layouts/_flash_messages.html.haml', file_url('views/_flash_messages.html.haml'))
get_file('app/views/layouts/_footer.html.haml', file_url('views/_footer.html.haml'))
get_file('app/views/layouts/_error_messages_for.html.haml', file_url('views/_error_messages_for.html.haml'))


insert_into_file 'app/helpers/application_helper.rb', :after => "module ApplicationHelper\n" do

  <<-DATA

  def copyright_years
    year1=2013
    year2=Date.today.year
    res="© МГИУ, "
    res+=year1==year2 ? "\#{year1}" : "\#{year1}–\#{year2}"
    content_tag(:span, res)
  end


  def error_messages_for(object)
    render 'layouts/error_messages_for', object: object
  end
  DATA
end

#stylesheets
colors={'msiu-red' => '#9e2341', 'msiu-gray' => '#a7a9ac', :turquoise => '#1abc9c', :emerland => '#2ecc71', :peterriver => '#3498db',
        :amethyst => '#9b59b6', :wetasphalt => '#34495e', :greensea => '#16a085', :nephritis => '#27ae60', :belizehole => '#2980b9',
        :wisteria => '#8e44ad', :midnightblue => '#2c3e50', :sunflower => '#f1c40f', :carrot => '#e67e22', :alizarin => '#e74c3c',
        :clouds => '#ecf0f1', :concrete => '#95a5a6', :orange => '#f39c12', :pumpkin => '#d35400', :pomegranate => '#c0392b',
        :silver => '#bdc3c7', :asbestos => '#7f8c8d'}

file 'app/assets/stylesheets/colors.css.scss', colors.map { |k, v| "$#{k}: #{v};" }.join("\n")

append_file 'app/assets/stylesheets/colors.css.scss', "\n$color_names: #{colors.keys.join(' ')};\n $color_values: #{colors.keys.map { |x| " $#{x}" }.join(' ')};\n"

%w(buttons footer main).each { |x| get_file "app/assets/stylesheets/#{x}.css.scss", file_url("stylesheets/#{x}.css.scss") }


insert_into_file 'app/assets/stylesheets/application.css', " *= require font-awesome\n", :before => /^\s*\*=\s*require_tree\s+\./
insert_into_file 'app/assets/stylesheets/application.css', " *= require fonts\n", :before => /^\s*\*=\s*require_tree\s+\./
insert_into_file 'app/assets/stylesheets/application.css', " *= require main\n", :before => /^\s*\*=\s*require_tree\s+\./
gsub_file 'app/assets/stylesheets/application.css', /^.*require_tree.*$/,"\n"
insert_into_file 'app/assets/javascripts/application.js', "//= require 'bootstrap'\n", :before => /^\s*\/\/=\s*require_tree\s+\./


#CAS
cas=yes?("CAS?")
if cas
  gem 'rubycas-client-msiu'
  get_file 'config/initializers/cas.rb', file_url('cas.rb')
end


get_file 'app/views/layouts/error.html.haml', file_url('views/error.html.haml')


#Kaminari
kaminari=yes?("Kaminari")
if kaminari
  gem 'kaminari'
  append_file 'config/locales/ru.yml', <<-DATA
  views:
    pagination:
      first: ⇤
      last: ⇥
      previous: ←
      next: →
      truncate: …
  DATA
end

#Git

git :init
git :add => "."
append_file '.gitignore', '/.idea'
git :commit => %Q{ -m 'Initial commit' }


run 'bundle install'

#After bundle

generate('kaminari:views', 'bootstrap', '-e', 'haml') if kaminari

#generate User model
if cas
  generate(:model, "User login surname name patronymic roles:integer")
  rake 'db:create db:migrate'
  #logout
  generate(:controller, "Sessions")
  insert_into_file 'app/controllers/sessions_controller.rb', :before => /^.*end\s*\z/u do
    <<-DATA
    def destroy
      CASClient::Frameworks::Rails::Filter.logout(self)
    end
    DATA
  end
  route "get 'logout'=>'sessions#destroy',as: :logout"


  insert_into_file 'app/controllers/application_controller.rb', :before => /end\s*\z/u do
    <<-DATA
    before_filter :check_auth
    before_filter :check_authentication

    helper_method :current_login

    private

    def check_auth
      unless request.xhr? || request.post? || request.patch?
        CASClient::Frameworks::Rails::Filter.filter(self)
      end
    end

    def check_authentication
      @current_user=User.where(login: current_login).first if current_login.present?
      unless @current_user
        render_error("Пользователь не найден")
      end
    end

    def current_login
      session[:cas_user]
    end
    DATA
  end
end

#render_error
insert_into_file 'app/controllers/application_controller.rb', :before => /end\s*\z/ do
  <<-DATA
  def render_error(error='Произошла ошибка', status=404)
    @error=error
    respond_to do |format|
      format.html{ render 'layouts/error', status: status}
      format.js{render text: "alert('\#{j(@error)}');", status: status}
      format.json {render json: {error: @error}, status: status}
      format.xml {render xml: {error: @error}, status: status}
    end
  end
  DATA
end
