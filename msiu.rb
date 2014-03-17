# -*- coding: utf-8 -*-
require 'base64'
require 'thor'


# Баг в Thor. binread всегда считывает US-ASCII
File.instance_eval do
  def binread(file)
    File.open(file, "rb:#{Encoding.default_external.to_s}") { |f| f.read }
  end
end


#Загрузка изображений МГИУ

favicon_data="R0lGODlhEAAQANUAAKaiou3q6ubk5JWQkLm2ttHLy9nU1L29vZaRke7a2vn4\n+NOBgby5udjT0+Pe3vv09NDNzcvIyOnX17cyMt2fn7YvL8jFxbo8PLxBQdm7\nu9PR0ZKNjf36+vb09O3r6/r5+ejn5+Le3urn5767u9HKyv39/aSgoMZbW+Cm\npq6srM1zc9DPz+/h4fHv793CwpSQkOTg4NLMzPj399rV1c7MzLOwsOXh4aGd\nneLg4P38/MJRUbUtLZGMjP///8/IyAAAACH5BAAAAAAALAAAAAAQABAAAAZ4\nwJbBRywaiQZRL3Bs+gI9QK7gLBZKAF7PUSXCejweQND1gUy8AU/QqM5w6TCD\n6fQQwmGEgtSMfV54YRohTTY0gWEAHU0yN4g8CAk9k5QJG48rFDubnCgQiBEZ\nFZycEy4WeCMSF6SkGCx3KQ86ra0nHDUHKrW1CwdBADs=\n"
file 'public/favicon.ico', Base64.decode64(favicon_data)


logo_data="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\nZ7WgAAAAAElFTkSuQmCC\n"
file 'app/assets/images/logo.png', Base64.decode64(logo_data)

#Имя пользователя и пароль к БД

db_username=ask("Database username:")
puts db_username
db_password=ask("Database password:")

gsub_file 'config/database.yml', /username:.*$/, "username: #{db_username}" if db_username.present?
gsub_file 'config/database.yml', /password:.*$/, "password: #{db_password}" if db_password.present?

#Настройка локали
gem 'rails-i18n'
gsub_file 'config/application.rb', /^.*#.*config.i18n.default_locale\s*=.*$/, '  config.i18n.default_locale = :ru'
file 'config/locales/ru.yml', <<-DATA
ru:
  helpers:   
    submit:
      create: Сохранить
      submit: Сохранить
      update: Сохранить
DATA

#fonts
insert_into_file 'config/application.rb', :before=> /\s+end\s+end\s*\z/ do
  "\n    config.assets.paths << \"\#{Rails}/vendor/assets/fonts\"\n"
end

#Установка часового пояса
gsub_file 'config/application.rb', /^.*#.*config.time_zone\s*=.*$/, '  config.time_zone = \'Moscow\''


#Gemfile
gem 'haml'
gem 'haml-rails'
gem 'therubyracer', :platforms => :ruby

gem_group :development, :test do
  gem "rspec-rails"
end


#routes
generate('controller', 'welcome', 'index')
route "root to: 'welcome#index'"

#Twitter Bootstrap
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails', :github => 'anjlab/bootstrap-rails'
run 'bundle install'
gem 'font-awesome-rails'
run 'rm app/views/layouts/application.html.erb'
file 'app/views/layouts/application.html.haml', <<-DATA

!!! 5
%html
  %head
    %title ФГБОУ ВПО «МГИУ»
    %meta{charset: 'utf-8'}
    %meta{name: 'viewport', content: "width=device-width, initial-scale=1.0"}
    =stylesheet_link_tag "application", media: "all", "data-turbolinks-track" => true
    =javascript_include_tag "application", "data-turbolinks-track" => true
    = csrf_meta_tags
  %body
    #wrap
      .navbar
        .container
          .navbar-header
            =link_to root_path,class: 'navbar-brand' do
              =image_tag('logo.png', alt: 'ФГБОУ ВПО «МГИУ»')
          .pull-right.intro.navbar-header
            .navbar-brand2
              =link_to root_path,class: 'brand' do
                %span.msiu-red
                  ФГБОУ ВПО
                «МГИУ»
      .container.main
        =render 'welcome/flash_messages'
        =yield
    %footer#footer
      =render 'layouts/footer'
DATA

file 'app/views/welcome/_flash_messages.html.haml', <<-DATA
-flash.each do |key,value|
  .alert{class: "alert-\#{key}"}=value
DATA

file 'app/views/layouts/_footer.html.haml', <<-DATA

.container
  .row
    .col-md-3.intro
      %ul.list-unstyled
        %li=link_to 'Главная страница МГИУ','http://live.msiu.ru', target: '_blank'
        %li=link_to 'Информационный портал МГИУ','http://www.main.msiu.ru', target: '_blank'
    .col-md-9
      .pull-left
        Разработано в ИВЦ МГИУ
      .pull-right
        =copyright_years
DATA

file 'app/views/welcome/_error_messages_for.html.haml', <<-DATA
-if object.errors.any?
  .panel.panel-danger
    .panel-heading
      При сохранении произошли ошибки
    .panel-body
      %ol
        -object.errors.full_messages.each do |msg|
          %li=msg
DATA


file 'app/views/layouts/_flash_messages.html.haml', <<-DATA
-flash.each do |name,msg|
  .alert{class: "alert-\#{name}"}=msg
DATA

insert_into_file 'app/helpers/application_helper.rb', :after => "module ApplicationHelper\n" do

  <<-DATA

  def copyright_years
    year1=2013
    year2=Date.today.year
    res="© МГИУ, "
    res+=year1==year2 ? "\#{year1}" : "\#{year1}–\#{year2}"
    content_tag(:span, res)
  end

  def quote(str,after=nil)
    "«\#{str}»\#{after}"
  end

  def error_messages_for(object)
    render 'welcome/error_messages_for', object: object
  end
  DATA
end

#stylesheets
colors={'msiu-red' => '#992441', 'msiu-gray' => '#a5a7aa', :turquoise => '#1abc9c', :emerland => '#2ecc71', :peterriver => '#3498db',
        :amethyst => '#9b59b6', :wetasphalt => '#34495e', :greensea => '#16a085', :nephritis => '#27ae60', :belizehole => '#2980b9',
        :wisteria => '#8e44ad', :midnightblue => '#2c3e50', :sunflower => '#f1c40f', :carrot => '#e67e22', :alizarin => '#e74c3c',
        :clouds => '#ecf0f1', :concrete => '#95a5a6', :orange => '#f39c12', :pumpkin => '#d35400', :pomegranate => '#c0392b',
        :silver => '#bdc3c7', :asbestos => '#7f8c8d'}

file 'app/assets/stylesheets/scaffolds.css.scss', colors.map { |k, v| "$#{k}: #{v};" }.join("\n")

append_file 'app/assets/stylesheets/scaffolds.css.scss', "\n$color_names: #{colors.keys.join(' ')};\n $color_values: #{colors.keys.map { |x| " $#{x}" }.join(' ')};\n"

append_file 'app/assets/stylesheets/scaffolds.css.scss', <<-DATA


$border-radius-base: 0;
$border-radius-large: 0;
$border-radius-small: 0;

$brand-primary: $belizehole;
$brand-success: $emerland;
$brand-warning: $orange;
$brand-info: $peterriver;
$brand-danger: $pomegranate;

$padding-base-vertical: 10px;
$padding-base-horizontal: 15px;
$padding-large-vertical: 16px;
$padding-large-horizontal: 20px;

$grid-gutter-width: 0;

$footer-height: 140px;
$footer-margin-top: 30px;
$footer-padding-vertical: 30px;
$footer-bg: #333;

$gray: #999;
$white: #fff;
$red: $alizarin;

@import 'twitter/bootstrap';


@import 'buttons';
@import 'footer';
@import 'flash_messages';

a.brand {
  @extend a.nounderline;
  color: $msiu-gray;
  /*text-shadow: 0 1px 1px #000;*/
  @include transition(all 1s);
  &:hover {
    color: $msiu-red;
    @include transition(all .5s);
  }
}

.nowrap {
  white-space: nowrap;
}
.navbar-brand2 {
  @extend .navbar-brand;
  font-size: 24px;
}
.required:after {
  content: '*';
  color: $red;
}

.field_with_errors {
  @extend .form-group;
  @extend .has-error;
}


a {
  text-decoration: none;
  &:hover, &:active {
    text-decoration: none;
  }
}


.msiu-red{
  color: $msiu-red;
}
.msiu-gray{
  color: $msiu-gray;
}

DATA


insert_into_file 'app/assets/stylesheets/application.css', " *= require font-awesome\n", :before => /^\s*\*=\s*require_tree\s+\./
insert_into_file 'app/assets/stylesheets/application.css', " *= require fonts\n", :before => /^\s*\*=\s*require_tree\s+\./
insert_into_file 'app/assets/javascripts/application.js', "//= require 'twitter/bootstrap'\n", :before => /^\s*\/\/=\s*require_tree\s+\./

file 'vendor/assets/stylesheets/buttons.css.scss', <<-DATA
@for $i from 1 through length($color_names) {
  @include button-variant(".btn-\#{nth($color_names, $i)}", #fff, nth($color_values, $i), nth($color_values, $i));
}
@include button-variant(".btn-clouds", $gray, $clouds,$clouds);
DATA

file 'vendor/assets/stylesheets/footer.css.scss', <<-DATA


/* Sticky footer styles
-------------------------------------------------- */

html,
body {
  height: 100%;
  /* The html and body elements cannot have any padding or margin. */
}

/* Wrapper for page content to push down footer */
#wrap {
  min-height: 100%;
  height: auto;
  /* Negative indent footer by its height */
  margin: 0 auto -1*($footer-height+2*$footer-padding-vertical);
  /* Pad bottom by footer height */
  padding: 0 0 ($footer-height+$footer-margin-top+20px);
}

/* Set the fixed height of the footer here */
#footer {
  min-height: $footer-height;
  height: auto;
  background: $footer-bg;
  padding:$footer-padding-vertical 0;
  margin-top: $footer-margin-top;
  color: $msiu-gray;
  a{
    color: $white;
    text-decoration: none;
    &:hover{
      color: $msiu-red;
      transition: .3s all ease;
    }

  }
}
DATA

file 'vendor/assets/stylesheets/flash_messages.css.scss', <<-DATA
.alert.alert-notice {
  @extend .alert;
  @extend .alert-success;
}
DATA


#CAS
cas=yes?("CAS?")
if cas
  add_source 'http://gems.msiu.ru'
  gem 'rubycas-client-msiu'
  file 'config/initializers/cas.rb', <<-DATA
CASSERVER = 'https://svc.msiu.ru/'

require 'casclient'
require 'casclient/frameworks/rails/filter'

CASClient::Frameworks::Rails::Filter.configure(
    :cas_base_url => CASSERVER
)
  DATA
end


file 'app/views/layouts/error.html.haml', ".alert.alert-danger=@error"


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

#Create database
rake 'db:migrate'

run 'bundle install'

#After bundle

generate('kaminari:views', 'bootstrap', '-e', 'haml') if kaminari

#generate User model
if cas
  generate(:model, "User login surname name patronymic roles:integer")
  #logout
  generate(:controller, "Sessions")
  insert_into_file 'app/controllers/sessions_controller.rb', :before => "^.*end\s*\z" do
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
      unless request.format.js?
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
