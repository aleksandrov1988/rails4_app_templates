require 'thor'
require 'open-uri'

$repo='https://raw.githubusercontent.com/aleksandrov1988/rails4_app_templates/rails42'

def get_file(path, options={})

  full_url=options[:url] || file_url(options[:path] || path)
  file path, open(full_url).read
end

def get_font(name)
  get_file "vendor/assets/fonts/#{name}"
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
#get_file 'public/favicon.ico', file_url('favicon.ico')
#get_file 'app/assets/images/logo.png', file_url('logo.png')


#Имя пользователя и пароль к БД

# db_username=ask("Database username:")
# db_password=ask("Database password:")
#
# gsub_file 'config/database.yml', /username:.*$/, "username: #{db_username}" if db_username.present?
# gsub_file 'config/database.yml', /password:.*$/, "password: #{db_password}" if db_password.present?

#Настройка локали
gem 'rails-i18n'
insert_into_file 'config/application.rb', '  config.i18n.default_locale = :ru', after: /^.*#.*default_locale\s*=.*$/
get_file 'config/locales/ru.yml'

#fonts
append_file 'config/initializers/assets.rb' do
  <<FONTS
Rails.application.config.assets.paths << "#{Rails}/vendor/assets/fonts"
Rails.application.config.assets.precompile += %w(*.svg *.eot *.woff *.ttf *.woff2)
FONTS
end
get_font('intro.woff')
get_font('open_sans.woff')
%w(bold italic light).each { |x| get_font("open_sans_#{x}.woff") }
get_font('ubuntu_mono.woff')
get_font('ubuntu_mono_bold.woff')
get_font('ubuntu_mono_italic.woff')

get_file 'vendor/assets/stylesheets/fonts.sass'


#Установка часового пояса
insert_into_file 'config/application.rb', '  config.time_zone = \'Moscow\'', after: /^.*#.*config.time_zone\s*=.*$/


gem 'haml-rails'
gem 'therubyracer', :platforms => :ruby


gem_group :development, :test do
  gem "rspec-rails"
end


#routes
generate('controller', 'welcome', 'index')
route "root 'welcome#index'"

#Twitter Bootstrap
gem 'bootstrap-sass'
run 'bundle install'
insert_into_file 'app/assets/javascripts/application.js', "//= require 'bootstrap'\n", before: /^\s*\/\/=\s*require_tree\s+\./

get_file 'app/assets/stylesheets/theme.sass'
gsub_file 'app/assets/stylesheets/application.css',/^.*\*=.*require_tree.*\..*$/,' *= require theme'
get_file 'app/assets/stylesheets/buttons.sass'
get_file 'app/assets/stylesheets/sidebar.sass'
get_file 'app/assets/stylesheets/main.sass'

#SASS
get_file 'config/initializers/scss.rb'

#Animate.css
get_file 'vendor/assets/stylesheets/animate.css', url: 'https://raw.github.com/daneden/animate.css/master/animate.css'
insert_into_file 'app/assets/stylesheets/theme.sass', "\n@import animate\n", after: /^.*@import .*bootstrap\s*$/

#Font Awesome
gem 'font-awesome-rails'


#layout and helpers
run 'rm app/views/layouts/application.html.erb'

get_file('app/views/layouts/application.html.haml')
get_file('app/views/application/_navbar_top.html.haml')
get_file('app/views/application/_sidebar.html.haml')
get_file('app/views/application/error.html.haml')


get_file('app/helpers/copyright_helper.rb')

if yes?("Need \"error messages for\"?")
  get_file('app/helpers/error_messages_helper.rb')
  get_file('app/views/application/_error_messages_for.html.haml')
  get_file('app/views/application/_error_messages_for_attr.html.haml')
end

if yes?("Need nested fields?")
  get_file 'app/helpers/fields_helper.rb'
  get_file 'app/assets/javascripts/fields.coffee'
end

if yes?("Need flash messages?")
  if yes?("Use growl?")
    get_file 'vendor/assets/javascripts/bootstrap-growl.min.js'
    get_file 'app/views/application/_flash_messages.html.haml', path: 'app/views/application/_flash_messages_growl.html.haml'
    insert_into_file 'app/assets/javascripts/application.js', "//= require bootstrap-growl.min\n", before: /^\s*\*=\s*require_tree\s+\./
  else
    get_file 'app/views/application/_flash_messages.html.haml'
  end
end

#stylesheets
# colors={'msiu-red' => '#9e2341', 'msiu-gray' => '#a7a9ac', :turquoise => '#1abc9c', :emerland => '#2ecc71', :peterriver => '#3498db',
#         :amethyst => '#9b59b6', :wetasphalt => '#34495e', :greensea => '#16a085', :nephritis => '#27ae60', :belizehole => '#2980b9',
#         :wisteria => '#8e44ad', :midnightblue => '#2c3e50', :sunflower => '#f1c40f', :carrot => '#e67e22', :alizarin => '#e74c3c',
#         :clouds => '#ecf0f1', :concrete => '#95a5a6', :orange => '#f39c12', :pumpkin => '#d35400', :pomegranate => '#c0392b',
#         :silver => '#bdc3c7', :asbestos => '#7f8c8d'}
#
# file 'app/assets/stylesheets/colors.css.scss', colors.map { |k, v| "$#{k}: #{v};" }.join("\n")
#
# append_file 'app/assets/stylesheets/colors.css.scss', "\n$color_names: #{colors.keys.join(' ')};\n $color_values: #{colors.keys.map { |x| " $#{x}" }.join(' ')};\n"



# insert_into_file 'app/assets/stylesheets/application.css', " *= require font-awesome\n", :before => /^\s*\*=\s*require_tree\s+\./
# insert_into_file 'app/assets/stylesheets/application.css', " *= require fonts\n", :before => /^\s*\*=\s*require_tree\s+\./
# insert_into_file 'app/assets/stylesheets/application.css', " *= require main\n", :before => /^\s*\*=\s*require_tree\s+\./
# gsub_file 'app/assets/stylesheets/application.css', /^.*require_tree.*$/, "\n"
# insert_into_file 'app/assets/javascripts/application.js', "//= require 'bootstrap'\n", :before => /^\s*\/\/=\s*require_tree\s+\./


#CAS
# cas=yes?("CAS?")
# if cas
#   gem 'rubycas-client-msiu'
#   get_file 'config/initializers/cas.rb', file_url('cas.rb')
# end


#Kaminari
kaminari=yes?("Use kaminari?")
if kaminari
  gem 'kaminari'
  gem 'kaminari-bootstrap'
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



#render_error
insert_into_file 'app/controllers/application_controller.rb', :before => /end\s*\z/ do
  <<-DATA
  private
  def render_error(error='Произошла ошибка', options={})
    @error=msg
    render 'error'
  end
  DATA
end
