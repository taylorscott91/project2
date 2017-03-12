# Project 2 Evaluation

## Technical Requirements
**1: Progressing**
>At least 1 model incorporates GET, POST, PUT, and DELETE routes, but no associations.

>Once you fix the bugs in your code per the suggestions in the inline comments, the app will fulfill the technical requirements.

## Creativity and Interface
**1: Progressing**
>The app is styled and has an interface of value to the end user: it is not just a nav bar and an index page.

>Think about how you could incorporate a more robust layout. The custom fonts and color scheme are a good start, however.

## Code Quality
**1: Progressing**
>Code lacks proper formatting, includes commented out, non-functional code, or otherwise contains major issues of quality (DRY, naming, etc)

> In particular, ensure that all of your links are configured correctly

## Deployment and Functionality
**1: Progressing**
>Application contains minimal functionality, but deployment is non-functional, or application contains major errors when used

>Once you fix the bugs and redeploy, this score will increase

## Planning / Process / Submission
**0: Incomplete**
>No submission received, or submission does not contain basic documentation of planning (ERD, wireframes, commit history, etc)

>Write up your readme.md with the information listed in the project prompt

## Inline Code Comments

```diff
[1mdiff --git a/app/controllers/games_controller.rb b/app/controllers/games_controller.rb[m
[1mindex c24460e..b272340 100644[m
[1m--- a/app/controllers/games_controller.rb[m
[1m+++ b/app/controllers/games_controller.rb[m
[36m@@ -15,27 +15,30 @@[m [mclass GamesController < ApplicationController[m
   def create[m
     @group = Group.find(params[:group_id])[m
     @group.games.create(game_params)[m
[31m-  #  @game = Game.create!(game_params)[m
[32m+[m[32m    # You are already assigning a group_id to the new game by using @group.games.create[m
 [m
[31m-    redirect_to group_games_path(@group)[m
[32m+[m[32m    redirect_to group_path(@group)[m
   end[m
 [m
   #show[m
   def show[m
[32m+[m[32m    @group = Group.find(params[:group_id])[m
     @game = Game.find(params[:id])[m
   end[m
 [m
   # edit[m
   def edit[m
[32m+[m[32m    @group = Group.find(params[:group_id])[m
     @game = Game.find(params[:id])[m
   end[m
 [m
   # update[m
   def update[m
[32m+[m[32m    @group = Group.find(params[:group_id])[m
     @game = Game.find(params[:id])[m
     @game.update(game_params)[m
 [m
[31m-    redirect_to games_path(@game)[m
[32m+[m[32m    redirect_to group_game_path(@group,@game)[m
   end[m
 [m
   # destroy[m
[36m@@ -48,6 +51,8 @@[m [mclass GamesController < ApplicationController[m
 [m
   private[m
   def game_params[m
[31m-    params.require(:game).permit(:name, :url, :group_id)[m
[32m+[m[32m    params.require(:game).permit(:name)[m
[32m+[m[32m    # This only filters out what can be submitted via form data. You only need to[m
[32m+[m[32m    # allow in :name[m
   end[m
 end[m
[1mdiff --git a/app/views/games/edit.html.erb b/app/views/games/edit.html.erb[m
[1mindex c444235..f7a074d 100644[m
[1m--- a/app/views/games/edit.html.erb[m
[1m+++ b/app/views/games/edit.html.erb[m
[36m@@ -1,15 +1,15 @@[m
 <h2>Edit Game</h2>[m
 [m
[31m-<%= form_for @game do |f| %>[m
[31m-  <%= f.label :title %>[m
[31m-  <%= f.text_field :title %>[m
[31m-[m
[32m+[m[32m<%= form_for [@group, @game] do |f| %>[m
[32m+[m[32m  <%= f.label :name %>[m
[32m+[m[32m  <%= f.text_field :name %>[m
[32m+[m[32m  <%# The attributes on a form_for must match those of the model it is creating / editing %>[m
   <%= f.label :group_id %>[m
   <%= f.text_field :group_id %>[m
 [m
   <%= f.submit %>[m
 <% end %>[m
 [m
[31m-<%= form_for @game, method: :delete do |f| %>[m
[32m+[m[32m<%= form_for [@group, @game], method: :delete do |f| %>[m
   <%= f.submit "Delete!", class: "delete" %>[m
 <% end %>[m
[1mdiff --git a/app/views/games/new.html.erb b/app/views/games/new.html.erb[m
[1mindex 0a64dc2..b7a20f8 100644[m
[1m--- a/app/views/games/new.html.erb[m
[1m+++ b/app/views/games/new.html.erb[m
[36m@@ -1,11 +1,13 @@[m
 <h2>New Game</h2>[m
 [m
 <%= form_for [@group, @game] do |f| %>[m
[31m-  <%= f.label :title %>[m
[31m-  <%= f.text_field :title %>[m
[31m-[m
[32m+[m[32m  <%= f.label :name %>[m
[32m+[m[32m  <%= f.text_field :name %>[m
[32m+[m[32m  <%# The error on new was because :title should be :name to match the attribute on the schema %>[m
   <%= f.label :group_id %>[m
   <%= f.text_field :group_id %>[m
[31m-[m
[32m+[m[32m  <%# You do not need a field for :group_id since you can do it in the controller's create action[m
[32m+[m[32m  by querying params for which group the game is being created in. Look in the controller for[m
[32m+[m[32m  an example of this %>[m
   <%= f.submit %>[m
 <% end %>[m
[1mdiff --git a/app/views/games/show.html.erb b/app/views/games/show.html.erb[m
[1mindex 245b78e..f221ef8 100644[m
[1m--- a/app/views/games/show.html.erb[m
[1m+++ b/app/views/games/show.html.erb[m
[36m@@ -1,2 +1,2 @@[m
[31m-<h2><%= @game.title %> <%= link_to "(edit)", edit_group_game_path(@game.group, @game) %></h2>[m
[31m-<h3>By: <%= @game.group.name %></h3>[m
[32m+[m[32m<h2><%= @game.name %> <%= link_to "(edit)", edit_group_game_path(@group, @game) %></h2>[m
[32m+[m[32m<h3>By: <%= @group.name %></h3>[m
[1mdiff --git a/app/views/groups/show.html.erb b/app/views/groups/show.html.erb[m
[1mindex 6984b7c..d31548b 100644[m
[1m--- a/app/views/groups/show.html.erb[m
[1m+++ b/app/views/groups/show.html.erb[m
[36m@@ -7,7 +7,7 @@[m
 <ul>[m
   <% @group.games.each do |game| %>[m
     <li>[m
[31m-      <%= group_game_path(@group, game) %>[m
[32m+[m[32m      <%= link_to game.name, group_game_path(@group, game) %>[m
     </li>[m
   <% end %>[m
 </ul>[m
[1mdiff --git a/app/views/layouts/application.html.erb b/app/views/layouts/application.html.erb[m
[1mindex 41df9b7..9300d35 100644[m
[1m--- a/app/views/layouts/application.html.erb[m
[1m+++ b/app/views/layouts/application.html.erb[m
[36m@@ -10,6 +10,10 @@[m
   </head>[m
 [m
   <body>[m
[32m+[m[32m    <%# You may want to consider adding a nav bar here to house a link to the home page %>[m
[32m+[m[32m    <nav>[m
[32m+[m[32m      <%= link_to "Home", root_path %>[m
[32m+[m[32m    </nav>[m
     <header><img src="https://wallpaperbrowse.com/media/images/the-games-logo.jpg"></header>[m
     <h1>Collect.       Trade.       Play.</h1>[m
 [m
[1mdiff --git a/config/routes.rb b/config/routes.rb[m
[1mindex 73ffb83..93dee71 100644[m
[1m--- a/config/routes.rb[m
[1m+++ b/config/routes.rb[m
[36m@@ -1,6 +1,6 @@[m
 Rails.application.routes.draw do[m
   root to: 'groups#index'[m
[31m-[m
[32m+[m[32m  # Good setup of root route and nesting resources[m
   resources :groups do[m
     resources :games[m
   end[m
[1mdiff --git a/db/migrate/20170302051926_create_games.rb b/db/migrate/20170302051926_create_games.rb[m
[1mindex 040544d..a3c5620 100644[m
[1m--- a/db/migrate/20170302051926_create_games.rb[m
[1m+++ b/db/migrate/20170302051926_create_games.rb[m
[36m@@ -5,4 +5,6 @@[m [mclass CreateGames < ActiveRecord::Migration[5.0][m
       t.integer :group_id[m
     end[m
   end[m
[32m+[m[32m  # Consider adding more attributes to your Game model here. Things such as a description,[m
[32m+[m[32m  # release year, number of players, etc.[m
 end[m
[1mdiff --git a/db/seeds.rb b/db/seeds.rb[m
[1mindex 67af464..88aaeb6 100644[m
[1m--- a/db/seeds.rb[m
[1m+++ b/db/seeds.rb[m
[36m@@ -17,3 +17,13 @@[m [mGame.create(name: "Destiny", group_id: 3)[m
 Game.create(name: "Betrayal at House on the Hill", group_id: 1)[m
 Game.create(name: "Takenoko", group_id: 1)[m
 Game.create(name: "Fluxx", group_id: 2)[m
[32m+[m
[32m+[m[32m# Always use bang (!) operators on .create!() to force potential errors to print to the terminal[m
[32m+[m[32m# When creating mutliple instances of a given model, you can use an array syntax:[m
[32m+[m[32m#[m
[32m+[m[32m# Game.create!([[m
[32m+[m[32m#   {name: "Destiny", group_id: 3},[m
[32m+[m[32m#   {name: "Betrayal at House on the Hill", group_id: 1},[m
[32m+[m[32m#   {name: "Takenoko", group_id: 1},[m
[32m+[m[32m#   {name: "Fluxx", group_id: 2}[m
[32m+[m[32m# ])[m
[1mdiff --git a/evaluation.md b/evaluation.md[m
[1mdeleted file mode 100644[m
[1mindex 5211f8b..0000000[m
[1m--- a/evaluation.md[m
[1m+++ /dev/null[m
[36m@@ -1,9 +0,0 @@[m
[31m-# Project Evaluation[m
[31m-[m
[31m-| Category                        | Incomplete                               | Progressing                              | Performing                               | Excelling                                |[m
[31m-| ------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- |[m
[31m-| Technical Requirements          | 0 Models, or partial CRUD on at least 1 model. | At least 1 model incorporates `GET`, `POST`, `PUT`, and `DELETE` routes, but no associations. | The app contains 2 models, with at least 1 association. At least 1 model is full CRUD. | Includes many well-structured models, and advanced functionality such as authorization, 3rd-party API integration, or other technology not covered in class |[m
[31m-| Creativity and Interface        | Zero or Minimal custom styles or interface. Evidence of scaffolded code | The app is styled and has an interface of value to the end user: it is not just a nav bar and an index page | The app displays a personal spin or creative element through its written language, functionality, purpose, and/or CSS.| The app is fully responsive, incorporates outside technologies such as Flexbox.  App incorporates modern UI themes, and adds unique  flair. |[m
[31m-| Code Quality                    | Minimal functional code is present       | Code lacks proper formatting, includes commented out, non-functional code, or otherwise contains major issues of quality (DRY, naming, etc) | Code is well-formatted, well-named, and contains few style / quality issues | No major code quality issues, makes use of Ruby best practices appropriately, and follows techniques such as separation of concerns, abstraction, and encapsulation |[m
[31m-| Functionality    | Application contains minimal functionality | Application contains minimal functionality and contains major errors when used | Application contains no major errors | App has advanced functionality that works with minimal errors, and may make use of advanced tools such as APIs, plugins, etc.  |[m
[31m-| Planning / Process / Submission | No submission received, or submission does not contain basic documentation of planning (ERD, wireframes, commit history, etc) | App is submitted, with basic evidence of planning. Documentation exists, but lacks common areas such as setup instructions, description of application functionality | Submission contains clear evidence of planning, adequate documentation, include all from previous category, as well as additional information such as unsolved issues. | Submission includes everything in previous category, as well as evidence of  planning tools, such as Trello, and, incorporates workflows such as feature branching, code review, github issue / user story tracking, and justification of technical decisions. |[m
[1mdiff --git a/gameapp/.gitignore b/gameapp/.gitignore[m
[1mdeleted file mode 100644[m
[1mindex 48fb168..0000000[m
[1m--- a/gameapp/.gitignore[m
[1m+++ /dev/null[m
[36m@@ -1,17 +0,0 @@[m
[31m-# See https://help.github.com/articles/ignoring-files for more about ignoring files.[m
[31m-#[m
[31m-# If you find yourself ignoring temporary files generated by your text editor[m
[31m-# or operating system, you probably want to add a global ignore instead:[m
[31m-#   git config --global core.excludesfile '~/.gitignore_global'[m
[31m-[m
[31m-# Ignore bundler config.[m
[31m-/.bundle[m
[31m-[m
[31m-# Ignore all logfiles and tempfiles.[m
[31m-/log/*[m
[31m-/tmp/*[m
[31m-!/log/.keep[m
[31m-!/tmp/.keep[m
[31m-[m
[31m-# Ignore Byebug command history file.[m
[31m-.byebug_history[m
[1mdiff --git a/gameapp/app/views/layouts/application.html.erb b/gameapp/app/views/layouts/application.html.erb[m
[1mdeleted file mode 100644[m
[1mindex 5d2f431..0000000[m
[1m--- a/gameapp/app/views/layouts/application.html.erb[m
[1m+++ /dev/null[m
[36m@@ -1,17 +0,0 @@[m
[31m-<!DOCTYPE html>[m
[31m-<html>[m
[31m-  <head>[m
[31m-    <title>GameCollectionApp</title>[m
[31m-    <%= csrf_meta_tags %>[m
[31m-[m
[31m-    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>[m
[31m-    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>[m
[31m-  </head>[m
[31m-[m
[31m-  <body>[m
[31m-    <header><img src="https://wallpaperbrowse.com/media/images/the-games-logo.jpg"></header>[m
[31m-    <h1>Collect.   Trade.    Play.</h1>[m
[31m-[m
[31m-    <%= yield %>[m
[31m-  </body>[m
[31m-</html>[m
[1mdiff --git a/log/development.log b/log/development.log[m
[1mindex dbd09ae..6732b6d 100644[m
[1m--- a/log/development.log[m
[1m+++ b/log/development.log[m
[36m@@ -1072,3 +1072,528 @@[m [mProcessing by GroupsController#show as HTML[m
 Completed 200 OK in 66ms (Views: 62.5ms | ActiveRecord: 1.1ms)[m
 [m
 [m
[32m+[m[32m  [1m[35m (0.4ms)[0m  [1m[35mDROP DATABASE IF EXISTS "gameapp_development"[0m[m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mDROP DATABASE IF EXISTS "gameapp_test"[0m[m
[32m+[m[32m  [1m[35m (301.8ms)[0m  [1m[35mCREATE DATABASE "gameapp_development" ENCODING = 'unicode'[0m[m
[32m+[m[32m  [1m[35m (229.7ms)[0m  [1m[35mCREATE DATABASE "gameapp_test" ENCODING = 'unicode'[0m[m
[32m+[m[32m  [1m[35mSQL (0.7ms)[0m  [1m[35mCREATE EXTENSION IF NOT EXISTS "plpgsql"[0m[m
[32m+[m[32m  [1m[35m (9.3ms)[0m  [1m[35mCREATE TABLE "games" ("id" serial primary key, "name" character varying, "group_id" integer)[0m[m
[32m+[m[32m  [1m[35m (3.1ms)[0m  [1m[35mCREATE TABLE "groups" ("id" serial primary key, "name" character varying)[0m[m
[32m+[m[32m  [1m[35m (2.6ms)[0m  [1m[35mCREATE TABLE "schema_migrations" ("version" character varying PRIMARY KEY)[0m[m
[32m+[m[32m  [1m[35m (0.4ms)[0m  [1m[34mSELECT version FROM "schema_migrations"[0m[m
[32m+[m[32m  [1m[35m (0.7ms)[0m  [1m[32mINSERT INTO "schema_migrations" (version) VALUES (20170302051926)[0m[m
[32m+[m[32m  [1m[35m (0.3ms)[0m  [1m[32mINSERT INTO "schema_migrations" (version) VALUES[m
[32m+[m[32m(20170302051917);[m
[32m+[m
[32m+[m[32m[0m[m
[32m+[m[32m  [1m[35m (2.3ms)[0m  [1m[35mCREATE TABLE "ar_internal_metadata" ("key" character varying PRIMARY KEY, "value" character varying, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL)[0m[m
[32m+[m[32m  [1m[36mActiveRecord::InternalMetadata Load (0.3ms)[0m  [1m[34mSELECT  "ar_internal_metadata".* FROM "ar_internal_metadata" WHERE "ar_internal_metadata"."key" = $1 LIMIT $2[0m  [["key", :environment], ["LIMIT", 1]][m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35mSQL (0.6ms)[0m  [1m[32mINSERT INTO "ar_internal_metadata" ("key", "value", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "key"[0m  [["key", "environment"], ["value", "development"], ["created_at", 2017-03-12 22:45:08 UTC], ["updated_at", 2017-03-12 22:45:08 UTC]][m
[32m+[m[32m  [1m[35m (0.2ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32m  [1m[36mActiveRecord::InternalMetadata Load (0.2ms)[0m  [1m[34mSELECT  "ar_internal_metadata".* FROM "ar_internal_metadata" WHERE "ar_internal_metadata"."key" = $1 LIMIT $2[0m  [["key", :environment], ["LIMIT", 1]][m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32m  [1m[35mSQL (0.2ms)[0m  [1m[35mCREATE EXTENSION IF NOT EXISTS "plpgsql"[0m[m
[32m+[m[32m  [1m[35m (6.3ms)[0m  [1m[35mCREATE TABLE "games" ("id" serial primary key, "name" character varying, "group_id" integer)[0m[m
[32m+[m[32m  [1m[35m (3.9ms)[0m  [1m[35mCREATE TABLE "groups" ("id" serial primary key, "name" character varying)[0m[m
[32m+[m[32m  [1m[35m (2.0ms)[0m  [1m[35mCREATE TABLE "schema_migrations" ("version" character varying PRIMARY KEY)[0m[m
[32m+[m[32m  [1m[35m (0.3ms)[0m  [1m[34mSELECT version FROM "schema_migrations"[0m[m
[32m+[m[32m  [1m[35m (0.3ms)[0m  [1m[32mINSERT INTO "schema_migrations" (version) VALUES (20170302051926)[0m[m
[32m+[m[32m  [1m[35m (0.3ms)[0m  [1m[32mINSERT INTO "schema_migrations" (version) VALUES[m
[32m+[m[32m(20170302051917);[m
[32m+[m
[32m+[m[32m[0m[m
[32m+[m[32m  [1m[35m (2.8ms)[0m  [1m[35mCREATE TABLE "ar_internal_metadata" ("key" character varying PRIMARY KEY, "value" character varying, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL)[0m[m
[32m+[m[32m  [1m[36mActiveRecord::InternalMetadata Load (0.4ms)[0m  [1m[34mSELECT  "ar_internal_metadata".* FROM "ar_internal_metadata" WHERE "ar_internal_metadata"."key" = $1 LIMIT $2[0m  [["key", :environment], ["LIMIT", 1]][m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35mSQL (0.3ms)[0m  [1m[32mINSERT INTO "ar_internal_metadata" ("key", "value", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "key"[0m  [["key", "environment"], ["value", "development"], ["created_at", 2017-03-12 22:45:08 UTC], ["updated_at", 2017-03-12 22:45:08 UTC]][m
[32m+[m[32m  [1m[35m (0.3ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32m  [1m[36mActiveRecord::InternalMetadata Load (0.2ms)[0m  [1m[34mSELECT  "ar_internal_metadata".* FROM "ar_internal_metadata" WHERE "ar_internal_metadata"."key" = $1 LIMIT $2[0m  [["key", :environment], ["LIMIT", 1]][m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32m  [1m[36mActiveRecord::SchemaMigration Load (0.3ms)[0m  [1m[34mSELECT "schema_migrations".* FROM "schema_migrations"[0m[m
[32m+[m[32m  [1m[36mGroup Load (0.5ms)[0m  [1m[34mSELECT "groups".* FROM "groups"[0m[m
[32m+[m[32m  [1m[36mGame Load (0.4ms)[0m  [1m[34mSELECT "games".* FROM "games"[0m[m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35mSQL (0.5ms)[0m  [1m[32mINSERT INTO "groups" ("name") VALUES ($1) RETURNING "id"[0m  [["name", "Board Games"]][m
[32m+[m[32m  [1m[35m (0.3ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35mSQL (0.2ms)[0m  [1m[32mINSERT INTO "groups" ("name") VALUES ($1) RETURNING "id"[0m  [["name", "Card Games"]][m
[32m+[m[32m  [1m[35m (0.3ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35mSQL (0.2ms)[0m  [1m[32mINSERT INTO "groups" ("name") VALUES ($1) RETURNING "id"[0m  [["name", "Video Games - PS4"]][m
[32m+[m[32m  [1m[35m (0.2ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35mSQL (0.3ms)[0m  [1m[32mINSERT INTO "games" ("name", "group_id") VALUES ($1, $2) RETURNING "id"[0m  [["name", "Destiny"], ["group_id", 3]][m
[32m+[m[32m  [1m[35m (0.2ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35mSQL (0.2ms)[0m  [1m[32mINSERT INTO "games" ("name", "group_id") VALUES ($1, $2) RETURNING "id"[0m  [["name", "Betrayal at House on the Hill"], ["group_id", 1]][m
[32m+[m[32m  [1m[35m (0.2ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35mSQL (0.2ms)[0m  [1m[32mINSERT INTO "games" ("name", "group_id") VALUES ($1, $2) RETURNING "id"[0m  [["name", "Takenoko"], ["group_id", 1]][m
[32m+[m[32m  [1m[35m (0.2ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35mSQL (0.2ms)[0m  [1m[32mINSERT INTO "games" ("name", "group_id") VALUES ($1, $2) RETURNING "id"[0m  [["name", "Fluxx"], ["group_id", 2]][m
[32m+[m[32m  [1m[35m (0.3ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32mStarted GET "/" for ::1 at 2017-03-12 18:45:23 -0400[m
[32m+[m[32m  [1m[36mActiveRecord::SchemaMigration Load (0.4ms)[0m  [1m[34mSELECT "schema_migrations".* FROM "schema_migrations"[0m[m
[32m+[m[32mProcessing by GroupsController#index as HTML[m
[32m+[m[32m  Rendering groups/index.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGroup Load (0.6ms)[0m  [1m[34mSELECT "groups".* FROM "groups"[0m[m
[32m+[m[32m  Rendered groups/index.html.erb within layouts/application (12.4ms)[m
[32m+[m[32mCompleted 200 OK in 337ms (Views: 320.2ms | ActiveRecord: 4.8ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1" for ::1 at 2017-03-12 18:45:26 -0400[m
[32m+[m[32mProcessing by GroupsController#show as HTML[m
[32m+[m[32m  Parameters: {"id"=>"1"}[m
[32m+[m[32m  [1m[36mGroup Load (0.4ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  Rendering groups/show.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGame Load (0.2ms)[0m  [1m[34mSELECT "games".* FROM "games" WHERE "games"."group_id" = $1[0m  [["group_id", 1]][m
[32m+[m[32m  Rendered groups/show.html.erb within layouts/application (20.2ms)[m
[32m+[m[32mCompleted 200 OK in 40ms (Views: 31.0ms | ActiveRecord: 3.9ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1/games" for ::1 at 2017-03-12 18:45:35 -0400[m
[32m+[m[32mProcessing by GamesController#index as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"1"}[m
[32m+[m[32m  Rendering games/index.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/index.html.erb within layouts/application (90.7ms)[m
[32m+[m[32mCompleted 500 Internal Server Error in 95ms (ActiveRecord: 0.0ms)[m
[32m+[m
[32m+[m
[32m+[m[41m  [m
[32m+[m[32mActionView::Template::Error (undefined local variable or method `new_game_path' for #<#<Class:0x007faef3d04298>:0x007faef3d17960>[m
[32m+[m[32mDid you mean?  new_group_game_path[m
[32m+[m[32m               new_group_path):[m
[32m+[m[32m    1: <h2>Games <%= link_to "(+)", new_game_path %></h2>[m
[32m+[m[32m    2:[m[41m [m
[32m+[m[32m    3: <ul>[m
[32m+[m[32m    4:   <% @games.each do |game| %>[m
[32m+[m[41m  [m
[32m+[m[32mapp/views/games/index.html.erb:1:in `_app_views_games_index_html_erb___1643646338717240034_70194695775640'[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/template_error.html.erb within rescues/layout[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_source.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_source.html.erb (3.5ms)[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb (1.4ms)[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb (1.1ms)[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/template_error.html.erb within rescues/layout (48.0ms)[m
[32m+[m[32mStarted GET "/groups/1/games/2" for ::1 at 2017-03-12 18:45:39 -0400[m
[32m+[m[32mProcessing by GamesController#show as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"1", "id"=>"2"}[m
[32m+[m[32m  [1m[36mGame Load (0.2ms)[0m  [1m[34mSELECT  "games".* FROM "games" WHERE "games"."id" = $1 LIMIT $2[0m  [["id", 2], ["LIMIT", 1]][m
[32m+[m[32m  Rendering games/show.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/show.html.erb within layouts/application (4.6ms)[m
[32m+[m[32mCompleted 500 Internal Server Error in 10ms (ActiveRecord: 0.2ms)[m
[32m+[m
[32m+[m
[32m+[m[41m  [m
[32m+[m[32mActionView::Template::Error (undefined method `title' for #<Game id: 2, name: "Betrayal at House on the Hill", group_id: 1>):[m
[32m+[m[32m    1: <h2><%= @game.title %> <%= link_to "(edit)", edit_group_game_path(@game.group, @game) %></h2>[m
[32m+[m[32m    2: <h3>By: <%= @game.group.name %></h3>[m
[32m+[m[41m  [m
[32m+[m[32mapp/views/games/show.html.erb:1:in `_app_views_games_show_html_erb___4009974810828818499_70194769352620'[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/template_error.html.erb within rescues/layout[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_source.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_source.html.erb (5.0ms)[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb (2.7ms)[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb (1.1ms)[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/template_error.html.erb within rescues/layout (47.3ms)[m
[32m+[m[32mStarted GET "/" for ::1 at 2017-03-12 19:00:48 -0400[m
[32m+[m[32m  [1m[36mActiveRecord::SchemaMigration Load (0.2ms)[0m  [1m[34mSELECT "schema_migrations".* FROM "schema_migrations"[0m[m
[32m+[m[32mProcessing by GroupsController#index as HTML[m
[32m+[m[32m  Rendering groups/index.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGroup Load (0.3ms)[0m  [1m[34mSELECT "groups".* FROM "groups"[0m[m
[32m+[m[32m  Rendered groups/index.html.erb within layouts/application (6.4ms)[m
[32m+[m[32mCompleted 200 OK in 21ms (Views: 14.5ms | ActiveRecord: 3.7ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1" for ::1 at 2017-03-12 19:00:51 -0400[m
[32m+[m[32mProcessing by GroupsController#show as HTML[m
[32m+[m[32m  Parameters: {"id"=>"1"}[m
[32m+[m[32m  [1m[36mGroup Load (0.4ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  Rendering groups/show.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGame Load (0.2ms)[0m  [1m[34mSELECT "games".* FROM "games" WHERE "games"."group_id" = $1[0m  [["group_id", 1]][m
[32m+[m[32m  Rendered groups/show.html.erb within layouts/application (11.2ms)[m
[32m+[m[32mCompleted 200 OK in 27ms (Views: 20.1ms | ActiveRecord: 3.8ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1/games/new" for ::1 at 2017-03-12 19:00:54 -0400[m
[32m+[m[32mProcessing by GamesController#new as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"1"}[m
[32m+[m[32m  [1m[36mGroup Load (0.3ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  Rendering games/new.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/new.html.erb within layouts/application (14.5ms)[m
[32m+[m[32mCompleted 200 OK in 33ms (Views: 28.7ms | ActiveRecord: 0.3ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted POST "/groups/1/games" for ::1 at 2017-03-12 19:00:59 -0400[m
[32m+[m[32mProcessing by GamesController#create as HTML[m
[32m+[m[32m  Parameters: {"utf8"=>"✓", "authenticity_token"=>"r5Dv4cERA1qgxEGIoPEdMwRwksD4NXnfEHni1+Dt0sxPIh61DjEMkMByfgAirKvpe14jxMQw8LuUIXgocmGR9w==", "game"=>{"name"=>"test", "group_id"=>"1"}, "commit"=>"Create Game", "group_id"=>"1"}[m
[32m+[m[32m  [1m[36mGroup Load (0.2ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  [1m[35m (0.2ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35mSQL (0.6ms)[0m  [1m[32mINSERT INTO "games" ("name", "group_id") VALUES ($1, $2) RETURNING "id"[0m  [["name", "test"], ["group_id", 1]][m
[32m+[m[32m  [1m[35m (0.3ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32mRedirected to http://localhost:3000/groups/1/games[m
[32m+[m[32mCompleted 302 Found in 6ms (ActiveRecord: 1.4ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1/games" for ::1 at 2017-03-12 19:00:59 -0400[m
[32m+[m[32mProcessing by GamesController#index as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"1"}[m
[32m+[m[32m  Rendering games/index.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/index.html.erb within layouts/application (77.1ms)[m
[32m+[m[32mCompleted 500 Internal Server Error in 81ms (ActiveRecord: 0.0ms)[m
[32m+[m
[32m+[m
[32m+[m[41m  [m
[32m+[m[32mActionView::Template::Error (undefined local variable or method `new_game_path' for #<#<Class:0x007faef3d370d0>:0x007faef8a0adf8>[m
[32m+[m[32mDid you mean?  new_group_game_path[m
[32m+[m[32m               new_group_path):[m
[32m+[m[32m    1: <h2>Games <%= link_to "(+)", new_game_path %></h2>[m
[32m+[m[32m    2:[m[41m [m
[32m+[m[32m    3: <ul>[m
[32m+[m[32m    4:   <% @games.each do |game| %>[m
[32m+[m[41m  [m
[32m+[m[32mapp/views/games/index.html.erb:1:in `_app_views_games_index_html_erb___1643646338717240034_70194736159720'[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/template_error.html.erb within rescues/layout[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_source.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_source.html.erb (3.4ms)[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb (1.3ms)[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb (0.6ms)[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/template_error.html.erb within rescues/layout (43.8ms)[m
[32m+[m[32mStarted GET "/groups/1" for ::1 at 2017-03-12 19:01:47 -0400[m
[32m+[m[32mProcessing by GroupsController#show as HTML[m
[32m+[m[32m  Parameters: {"id"=>"1"}[m
[32m+[m[32m  [1m[36mGroup Load (0.3ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  Rendering groups/show.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGame Load (0.3ms)[0m  [1m[34mSELECT "games".* FROM "games" WHERE "games"."group_id" = $1[0m  [["group_id", 1]][m
[32m+[m[32m  Rendered groups/show.html.erb within layouts/application (2.5ms)[m
[32m+[m[32mCompleted 200 OK in 20ms (Views: 17.4ms | ActiveRecord: 0.6ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1" for ::1 at 2017-03-12 19:02:21 -0400[m
[32m+[m[32mProcessing by GroupsController#show as HTML[m
[32m+[m[32m  Parameters: {"id"=>"1"}[m
[32m+[m[32m  [1m[36mGroup Load (0.2ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  Rendering groups/show.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGame Load (0.2ms)[0m  [1m[34mSELECT "games".* FROM "games" WHERE "games"."group_id" = $1[0m  [["group_id", 1]][m
[32m+[m[32m  Rendered groups/show.html.erb within layouts/application (11.0ms)[m
[32m+[m[32mCompleted 200 OK in 31ms (Views: 19.9ms | ActiveRecord: 6.3ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1/games/new" for ::1 at 2017-03-12 19:02:24 -0400[m
[32m+[m[32mProcessing by GamesController#new as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"1"}[m
[32m+[m[32m  [1m[36mGroup Load (0.2ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  Rendering games/new.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/new.html.erb within layouts/application (2.4ms)[m
[32m+[m[32mCompleted 200 OK in 19ms (Views: 15.7ms | ActiveRecord: 0.2ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted POST "/groups/1/games" for ::1 at 2017-03-12 19:02:29 -0400[m
[32m+[m[32mProcessing by GamesController#create as HTML[m
[32m+[m[32m  Parameters: {"utf8"=>"✓", "authenticity_token"=>"ZWInP7q/UPEUG9GZWEqdl7e2GgVru2881FT7TsSaYoKF0NZrdZ9fO3St7hHaFytNyJirAVe+5lhQDGGxVhYhuQ==", "game"=>{"name"=>"test", "group_id"=>"1"}, "commit"=>"Create Game", "group_id"=>"1"}[m
[32m+[m[32m  [1m[36mGroup Load (0.2ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35mSQL (0.3ms)[0m  [1m[32mINSERT INTO "games" ("name", "group_id") VALUES ($1, $2) RETURNING "id"[0m  [["name", "test"], ["group_id", 1]][m
[32m+[m[32m  [1m[35m (0.3ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32mRedirected to http://localhost:3000/groups/1[m
[32m+[m[32mCompleted 302 Found in 5ms (ActiveRecord: 0.8ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1" for ::1 at 2017-03-12 19:02:29 -0400[m
[32m+[m[32mProcessing by GroupsController#show as HTML[m
[32m+[m[32m  Parameters: {"id"=>"1"}[m
[32m+[m[32m  [1m[36mGroup Load (0.1ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  Rendering groups/show.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGame Load (0.2ms)[0m  [1m[34mSELECT "games".* FROM "games" WHERE "games"."group_id" = $1[0m  [["group_id", 1]][m
[32m+[m[32m  Rendered groups/show.html.erb within layouts/application (1.8ms)[m
[32m+[m[32mCompleted 200 OK in 16ms (Views: 13.9ms | ActiveRecord: 0.3ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1" for ::1 at 2017-03-12 19:04:43 -0400[m
[32m+[m[32mProcessing by GroupsController#show as HTML[m
[32m+[m[32m  Parameters: {"id"=>"1"}[m
[32m+[m[32m  [1m[36mGroup Load (0.1ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  Rendering groups/show.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGame Load (0.2ms)[0m  [1m[34mSELECT "games".* FROM "games" WHERE "games"."group_id" = $1[0m  [["group_id", 1]][m
[32m+[m[32m  Rendered groups/show.html.erb within layouts/application (10.4ms)[m
[32m+[m[32mCompleted 200 OK in 30ms (Views: 18.5ms | ActiveRecord: 6.2ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1/games/2" for ::1 at 2017-03-12 19:04:45 -0400[m
[32m+[m[32mProcessing by GamesController#show as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"1", "id"=>"2"}[m
[32m+[m[32m  [1m[36mGame Load (0.3ms)[0m  [1m[34mSELECT  "games".* FROM "games" WHERE "games"."id" = $1 LIMIT $2[0m  [["id", 2], ["LIMIT", 1]][m
[32m+[m[32m  Rendering games/show.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/show.html.erb within layouts/application (4.9ms)[m
[32m+[m[32mCompleted 500 Internal Server Error in 11ms (ActiveRecord: 0.3ms)[m
[32m+[m
[32m+[m
[32m+[m[41m  [m
[32m+[m[32mActionView::Template::Error (undefined method `title' for #<Game id: 2, name: "Betrayal at House on the Hill", group_id: 1>):[m
[32m+[m[32m    1: <h2><%= @game.title %> <%= link_to "(edit)", edit_group_game_path(@game.group, @game) %></h2>[m
[32m+[m[32m    2: <h3>By: <%= @game.group.name %></h3>[m
[32m+[m[41m  [m
[32m+[m[32mapp/views/games/show.html.erb:1:in `_app_views_games_show_html_erb___4009974810828818499_70194769777500'[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/template_error.html.erb within rescues/layout[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_source.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_source.html.erb (3.7ms)[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb (1.7ms)[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb (0.7ms)[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/template_error.html.erb within rescues/layout (48.5ms)[m
[32m+[m[32mStarted GET "/groups/1/games/2" for ::1 at 2017-03-12 19:05:55 -0400[m
[32m+[m[32mProcessing by GamesController#show as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"1", "id"=>"2"}[m
[32m+[m[32m  [1m[36mGroup Load (0.1ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  [1m[36mGame Load (0.2ms)[0m  [1m[34mSELECT  "games".* FROM "games" WHERE "games"."id" = $1 LIMIT $2[0m  [["id", 2], ["LIMIT", 1]][m
[32m+[m[32m  Rendering games/show.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/show.html.erb within layouts/application (0.5ms)[m
[32m+[m[32mCompleted 200 OK in 33ms (Views: 12.3ms | ActiveRecord: 6.1ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1/games/2/edit" for ::1 at 2017-03-12 19:06:49 -0400[m
[32m+[m[32mProcessing by GamesController#edit as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"1", "id"=>"2"}[m
[32m+[m[32m  [1m[36mGame Load (0.4ms)[0m  [1m[34mSELECT  "games".* FROM "games" WHERE "games"."id" = $1 LIMIT $2[0m  [["id", 2], ["LIMIT", 1]][m
[32m+[m[32m  Rendering games/edit.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/edit.html.erb within layouts/application (45.4ms)[m
[32m+[m[32mCompleted 500 Internal Server Error in 52ms (ActiveRecord: 0.4ms)[m
[32m+[m
[32m+[m
[32m+[m[41m  [m
[32m+[m[32mActionView::Template::Error (undefined method `game_path' for #<#<Class:0x007faefcb7d4c0>:0x007faef3e58518>[m
[32m+[m[32mDid you mean?  image_path):[m
[32m+[m[32m    1: <h2>Edit Game</h2>[m
[32m+[m[32m    2:[m[41m [m
[32m+[m[32m    3: <%= form_for @game do |f| %>[m
[32m+[m[32m    4:   <%= f.label :title %>[m
[32m+[m[32m    5:   <%= f.text_field :title %>[m
[32m+[m[32m    6:[m[41m [m
[32m+[m[41m  [m
[32m+[m[32mapp/views/games/edit.html.erb:3:in `_app_views_games_edit_html_erb__3350349418091218526_70194696472720'[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/template_error.html.erb within rescues/layout[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_source.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_source.html.erb (3.2ms)[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb (1.6ms)[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb (0.7ms)[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/template_error.html.erb within rescues/layout (44.7ms)[m
[32m+[m[32mStarted GET "/groups/1/games/2/edit" for ::1 at 2017-03-12 19:11:15 -0400[m
[32m+[m[32mProcessing by GamesController#edit as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"1", "id"=>"2"}[m
[32m+[m[32m  [1m[36mGroup Load (0.1ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  [1m[36mGame Load (0.2ms)[0m  [1m[34mSELECT  "games".* FROM "games" WHERE "games"."id" = $1 LIMIT $2[0m  [["id", 2], ["LIMIT", 1]][m
[32m+[m[32m  Rendering games/edit.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/edit.html.erb within layouts/application (42.8ms)[m
[32m+[m[32mCompleted 500 Internal Server Error in 61ms (ActiveRecord: 5.9ms)[m
[32m+[m
[32m+[m
[32m+[m[41m  [m
[32m+[m[32mActionView::Template::Error (undefined method `game_path' for #<#<Class:0x007faefc9d0dc0>:0x007faef3c93b88>[m
[32m+[m[32mDid you mean?  image_path):[m
[32m+[m[32m    10:   <%= f.submit %>[m
[32m+[m[32m    11: <% end %>[m
[32m+[m[32m    12:[m[41m [m
[32m+[m[32m    13: <%= form_for @game, method: :delete do |f| %>[m
[32m+[m[32m    14:   <%= f.submit "Delete!", class: "delete" %>[m
[32m+[m[32m    15: <% end %>[m
[32m+[m[41m  [m
[32m+[m[32mapp/views/games/edit.html.erb:13:in `_app_views_games_edit_html_erb__3350349418091218526_70194769595200'[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/template_error.html.erb within rescues/layout[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_source.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_source.html.erb (3.1ms)[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb (1.3ms)[m
[32m+[m[32m  Rendering /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb (0.9ms)[m
[32m+[m[32m  Rendered /Users/AndrewWhitley/.rvm/gems/ruby-2.3.1/gems/actionpack-5.0.2/lib/action_dispatch/middleware/templates/rescues/template_error.html.erb within rescues/layout (45.8ms)[m
[32m+[m[32mStarted GET "/groups/1/games/2/edit" for ::1 at 2017-03-12 19:11:35 -0400[m
[32m+[m[32mProcessing by GamesController#edit as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"1", "id"=>"2"}[m
[32m+[m[32m  [1m[36mGroup Load (0.2ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  [1m[36mGame Load (0.3ms)[0m  [1m[34mSELECT  "games".* FROM "games" WHERE "games"."id" = $1 LIMIT $2[0m  [["id", 2], ["LIMIT", 1]][m
[32m+[m[32m  Rendering games/edit.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/edit.html.erb within layouts/application (2.0ms)[m
[32m+[m[32mCompleted 200 OK in 24ms (Views: 20.7ms | ActiveRecord: 0.5ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1/games/2" for ::1 at 2017-03-12 19:11:41 -0400[m
[32m+[m[32mProcessing by GamesController#show as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"1", "id"=>"2"}[m
[32m+[m[32m  [1m[36mGroup Load (0.2ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  [1m[36mGame Load (0.1ms)[0m  [1m[34mSELECT  "games".* FROM "games" WHERE "games"."id" = $1 LIMIT $2[0m  [["id", 2], ["LIMIT", 1]][m
[32m+[m[32m  Rendering games/show.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/show.html.erb within layouts/application (0.7ms)[m
[32m+[m[32mCompleted 200 OK in 18ms (Views: 15.1ms | ActiveRecord: 0.3ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1/games/2" for ::1 at 2017-03-12 19:11:43 -0400[m
[32m+[m[32mProcessing by GamesController#show as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"1", "id"=>"2"}[m
[32m+[m[32m  [1m[36mGroup Load (0.2ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  [1m[36mGame Load (0.1ms)[0m  [1m[34mSELECT  "games".* FROM "games" WHERE "games"."id" = $1 LIMIT $2[0m  [["id", 2], ["LIMIT", 1]][m
[32m+[m[32m  Rendering games/show.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/show.html.erb within layouts/application (0.5ms)[m
[32m+[m[32mCompleted 200 OK in 16ms (Views: 13.9ms | ActiveRecord: 0.3ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/1" for ::1 at 2017-03-12 19:11:45 -0400[m
[32m+[m[32mProcessing by GroupsController#show as HTML[m
[32m+[m[32m  Parameters: {"id"=>"1"}[m
[32m+[m[32m  [1m[36mGroup Load (0.3ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 1], ["LIMIT", 1]][m
[32m+[m[32m  Rendering groups/show.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGame Load (0.2ms)[0m  [1m[34mSELECT "games".* FROM "games" WHERE "games"."group_id" = $1[0m  [["group_id", 1]][m
[32m+[m[32m  Rendered groups/show.html.erb within layouts/application (6.5ms)[m
[32m+[m[32mCompleted 200 OK in 23ms (Views: 19.8ms | ActiveRecord: 0.5ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups" for ::1 at 2017-03-12 19:11:51 -0400[m
[32m+[m[32mProcessing by GroupsController#index as HTML[m
[32m+[m[32m  Rendering groups/index.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGroup Load (0.2ms)[0m  [1m[34mSELECT "groups".* FROM "groups"[0m[m
[32m+[m[32m  Rendered groups/index.html.erb within layouts/application (1.3ms)[m
[32m+[m[32mCompleted 200 OK in 15ms (Views: 13.1ms | ActiveRecord: 0.2ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/2" for ::1 at 2017-03-12 19:11:54 -0400[m
[32m+[m[32mProcessing by GroupsController#show as HTML[m
[32m+[m[32m  Parameters: {"id"=>"2"}[m
[32m+[m[32m  [1m[36mGroup Load (0.3ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 2], ["LIMIT", 1]][m
[32m+[m[32m  Rendering groups/show.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGame Load (0.2ms)[0m  [1m[34mSELECT "games".* FROM "games" WHERE "games"."group_id" = $1[0m  [["group_id", 2]][m
[32m+[m[32m  Rendered groups/show.html.erb within layouts/application (2.2ms)[m
[32m+[m[32mCompleted 200 OK in 18ms (Views: 15.2ms | ActiveRecord: 0.5ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/2/games/new" for ::1 at 2017-03-12 19:11:58 -0400[m
[32m+[m[32mProcessing by GamesController#new as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"2"}[m
[32m+[m[32m  [1m[36mGroup Load (0.3ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 2], ["LIMIT", 1]][m
[32m+[m[32m  Rendering games/new.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/new.html.erb within layouts/application (1.6ms)[m
[32m+[m[32mCompleted 200 OK in 18ms (Views: 14.5ms | ActiveRecord: 0.3ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted POST "/groups/2/games" for ::1 at 2017-03-12 19:12:05 -0400[m
[32m+[m[32mProcessing by GamesController#create as HTML[m
[32m+[m[32m  Parameters: {"utf8"=>"✓", "authenticity_token"=>"r27/wdPfKwuexWl+ppf4//3yK07SkruSuWPGtQJkxV21ukOF1PPTeP1kV2LRlicEBxHSMsHvLi0Y8Gs9Rm33vg==", "game"=>{"name"=>"Test", "group_id"=>""}, "commit"=>"Create Game", "group_id"=>"2"}[m
[32m+[m[32m  [1m[36mGroup Load (0.2ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 2], ["LIMIT", 1]][m
[32m+[m[32mUnpermitted parameter: group_id[m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35mSQL (0.2ms)[0m  [1m[32mINSERT INTO "games" ("name", "group_id") VALUES ($1, $2) RETURNING "id"[0m  [["name", "Test"], ["group_id", 2]][m
[32m+[m[32m  [1m[35m (0.3ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32mRedirected to http://localhost:3000/groups/2[m
[32m+[m[32mCompleted 302 Found in 4ms (ActiveRecord: 0.8ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/2" for ::1 at 2017-03-12 19:12:05 -0400[m
[32m+[m[32mProcessing by GroupsController#show as HTML[m
[32m+[m[32m  Parameters: {"id"=>"2"}[m
[32m+[m[32m  [1m[36mGroup Load (0.1ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 2], ["LIMIT", 1]][m
[32m+[m[32m  Rendering groups/show.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGame Load (0.1ms)[0m  [1m[34mSELECT "games".* FROM "games" WHERE "games"."group_id" = $1[0m  [["group_id", 2]][m
[32m+[m[32m  Rendered groups/show.html.erb within layouts/application (1.8ms)[m
[32m+[m[32mCompleted 200 OK in 16ms (Views: 14.5ms | ActiveRecord: 0.2ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/2/games/7" for ::1 at 2017-03-12 19:12:07 -0400[m
[32m+[m[32mProcessing by GamesController#show as HTML[m
[32m+[m[32m  Parameters: {"group_id"=>"2", "id"=>"7"}[m
[32m+[m[32m  [1m[36mGroup Load (0.2ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 2], ["LIMIT", 1]][m
[32m+[m[32m  [1m[36mGame Load (0.2ms)[0m  [1m[34mSELECT  "games".* FROM "games" WHERE "games"."id" = $1 LIMIT $2[0m  [["id", 7], ["LIMIT", 1]][m
[32m+[m[32m  Rendering games/show.html.erb within layouts/application[m
[32m+[m[32m  Rendered games/show.html.erb within layouts/application (0.6ms)[m
[32m+[m[32mCompleted 200 OK in 19ms (Views: 15.5ms | ActiveRecord: 0.4ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups" for ::1 at 2017-03-12 19:18:05 -0400[m
[32m+[m[32mProcessing by GroupsController#index as HTML[m
[32m+[m[32m  Rendering groups/index.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGroup Load (0.3ms)[0m  [1m[34mSELECT "groups".* FROM "groups"[0m[m
[32m+[m[32m  Rendered groups/index.html.erb within layouts/application (6.1ms)[m
[32m+[m[32mCompleted 200 OK in 20ms (Views: 13.9ms | ActiveRecord: 3.5ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups" for ::1 at 2017-03-12 19:18:38 -0400[m
[32m+[m[32mProcessing by GroupsController#index as HTML[m
[32m+[m[32m  Rendering groups/index.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGroup Load (0.2ms)[0m  [1m[34mSELECT "groups".* FROM "groups"[0m[m
[32m+[m[32m  Rendered groups/index.html.erb within layouts/application (1.3ms)[m
[32m+[m[32mCompleted 200 OK in 14ms (Views: 12.3ms | ActiveRecord: 0.2ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/new" for ::1 at 2017-03-12 19:18:41 -0400[m
[32m+[m[32mProcessing by GroupsController#new as HTML[m
[32m+[m[32m  Rendering groups/new.html.erb within layouts/application[m
[32m+[m[32m  Rendered groups/new.html.erb within layouts/application (1.7ms)[m
[32m+[m[32mCompleted 200 OK in 18ms (Views: 15.8ms | ActiveRecord: 0.0ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted POST "/groups" for ::1 at 2017-03-12 19:18:45 -0400[m
[32m+[m[32mProcessing by GroupsController#create as HTML[m
[32m+[m[32m  Parameters: {"utf8"=>"✓", "authenticity_token"=>"fs1hNrqIpvROAilFVrvYHfOj02VGsxOYrh94ecVaeg+cXOrsCU/Z7Qv2RpRyNFDvI04CwLtRwjnZJJSX1+K/NA==", "group"=>{"name"=>"Xbox"}, "commit"=>"Create Group"}[m
[32m+[m[32m  [1m[35m (0.1ms)[0m  [1m[35mBEGIN[0m[m
[32m+[m[32m  [1m[35mSQL (0.8ms)[0m  [1m[32mINSERT INTO "groups" ("name") VALUES ($1) RETURNING "id"[0m  [["name", "Xbox"]][m
[32m+[m[32m  [1m[35m (0.3ms)[0m  [1m[35mCOMMIT[0m[m
[32m+[m[32mRedirected to http://localhost:3000/groups/4[m
[32m+[m[32mCompleted 302 Found in 3ms (ActiveRecord: 1.2ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/4" for ::1 at 2017-03-12 19:18:45 -0400[m
[32m+[m[32mProcessing by GroupsController#show as HTML[m
[32m+[m[32m  Parameters: {"id"=>"4"}[m
[32m+[m[32m  [1m[36mGroup Load (0.4ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 4], ["LIMIT", 1]][m
[32m+[m[32m  Rendering groups/show.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGame Load (0.2ms)[0m  [1m[34mSELECT "games".* FROM "games" WHERE "games"."group_id" = $1[0m  [["group_id", 4]][m
[32m+[m[32m  Rendered groups/show.html.erb within layouts/application (7.5ms)[m
[32m+[m[32mCompleted 200 OK in 21ms (Views: 15.9ms | ActiveRecord: 3.1ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups" for ::1 at 2017-03-12 19:18:49 -0400[m
[32m+[m[32mProcessing by GroupsController#index as HTML[m
[32m+[m[32m  Rendering groups/index.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGroup Load (0.4ms)[0m  [1m[34mSELECT "groups".* FROM "groups"[0m[m
[32m+[m[32m  Rendered groups/index.html.erb within layouts/application (2.0ms)[m
[32m+[m[32mCompleted 200 OK in 15ms (Views: 13.3ms | ActiveRecord: 0.4ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/4" for ::1 at 2017-03-12 19:18:52 -0400[m
[32m+[m[32mProcessing by GroupsController#show as HTML[m
[32m+[m[32m  Parameters: {"id"=>"4"}[m
[32m+[m[32m  [1m[36mGroup Load (0.3ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 4], ["LIMIT", 1]][m
[32m+[m[32m  Rendering groups/show.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGame Load (0.4ms)[0m  [1m[34mSELECT "games".* FROM "games" WHERE "games"."group_id" = $1[0m  [["group_id", 4]][m
[32m+[m[32m  Rendered groups/show.html.erb within layouts/application (2.3ms)[m
[32m+[m[32mCompleted 200 OK in 20ms (Views: 16.5ms | ActiveRecord: 0.7ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/groups/4" for ::1 at 2017-03-12 19:20:39 -0400[m
[32m+[m[32mProcessing by GroupsController#show as HTML[m
[32m+[m[32m  Parameters: {"id"=>"4"}[m
[32m+[m[32m  [1m[36mGroup Load (0.2ms)[0m  [1m[34mSELECT  "groups".* FROM "groups" WHERE "groups"."id" = $1 LIMIT $2[0m  [["id", 4], ["LIMIT", 1]][m
[32m+[m[32m  Rendering groups/show.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGame Load (0.3ms)[0m  [1m[34mSELECT "games".* FROM "games" WHERE "games"."group_id" = $1[0m  [["group_id", 4]][m
[32m+[m[32m  Rendered groups/show.html.erb within layouts/application (2.3ms)[m
[32m+[m[32mCompleted 200 OK in 25ms (Views: 22.6ms | ActiveRecord: 0.5ms)[m
[32m+[m
[32m+[m
[32m+[m[32mStarted GET "/" for ::1 at 2017-03-12 19:20:42 -0400[m
[32m+[m[32mProcessing by GroupsController#index as HTML[m
[32m+[m[32m  Rendering groups/index.html.erb within layouts/application[m
[32m+[m[32m  [1m[36mGroup Load (0.5ms)[0m  [1m[34mSELECT "groups".* FROM "groups"[0m[m
[32m+[m[32m  Rendered groups/index.html.erb within layouts/application (2.1ms)[m
[32m+[m[32mCompleted 200 OK in 20ms (Views: 17.0ms | ActiveRecord: 0.5ms)[m
[32m+[m
[32m+[m
[1mdiff --git a/presentations.md b/presentations.md[m
[1mdeleted file mode 100644[m
[1mindex 5f546ad..0000000[m
[1m--- a/presentations.md[m
[1m+++ /dev/null[m
[36m@@ -1,45 +0,0 @@[m
[31m-# Presentations[m
[31m-[m
[31m-You will prepare a short screencast (3-5 minutes) demonstrating your project, which you will upload to YouTube/Vimeo. We'll watch the presentations together![m
[31m-[m
[31m-### Warnings[m
[31m-[m
[31m-- **Do not put your video in your Github repository** or e-mail it to us, since it'll be at least 500MB.[m
[31m-- **Record a quick test video first.** Otherwise you'll end up with [this](https://www.youtube.com/watch?v=dCukspxmNDs).[m
[31m-- **Make sure your microphone is turned on.** See previous comment.[m
[31m-[m
[31m-### Hard Requirements[m
[31m-[m
[31m-Your video must be uploaded to YouTube, Vimeo or a similar service. **Please do not e-mail us your video or put it in a Github repository** since it will probably be at least 500MB.[m
[31m-[m
[31m-If you have a Gmail account, you already have a YouTube account. Just go to https://www.youtube.com/dashboard.[m
[31m-[m
[31m-**Your video must include...**[m
[31m-[m
[31m-- ...your voice loud enough to be heard. Speak loudly and clearly when recording![m
[31m-- ...a website or e-mail address through which you can be contacted. This can be included either in the video itself or as the video description (the text beneath YouTube videos).[m
[31m-- ...a description and demo of your app[m
[31m-- ...a code sample explaining one thing you're proud of[m
[31m-- ...one thing you would do differently next time[m
[31m-- ...the next feature you would like to implement[m
[31m-[m
[31m-### Submission Deadline: Thursday, March 2nd<sup>th</sup>, 12:00pm[m
[31m-[m
[31m-[m
[31m-## Recording a Video[m
[31m-[m
[31m-You may use any video-recording mechanism you wish. Whichever you choose, we recommend that you **make a quick test video first**.[m
[31m-[m
[31m-Include a link to your video as an issue on [the Project2-Gallery repository](https://github.com/ga-dc/project2-gallery).[m
[31m-[m
[31m-### QuickTime[m
[31m-[m
[31m-QuickTime Player is in the Applications folder of your Mac. Notice that if you go to the "File" menu you can create a "New Screen Recording"! This collects audio as well; it's how instructors screencast lessons. You can then save your video to your computer and upload it to YouTube.[m
[31m-[m
[31m-**Make sure you turn on the microphone before recording.**[m
[31m-[m
[31m-![Quicktime microphone](http://i.imgur.com/SBfletl.jpg)[m
[31m-[m
[31m-### iMovie[m
[31m-[m
[31m-If you're feeling really fancy you can use iMovie -- also in your Applications folder -- to swankify your video. However, this should be a priority far below actually completing your project. Having a snazzy-looking video isn't on the rubric![m
[1mdiff --git a/schedule.md b/schedule.md[m
[1mdeleted file mode 100644[m
[1mindex 8d8f7dd..0000000[m
[1m--- a/schedule.md[m
[1m+++ /dev/null[m
[36m@@ -1,27 +0,0 @@[m
[31m-# Project 2 Schedule[m
[31m-[m
[31m-**Attendance will be taken at 9:00am every morning**[m
[31m-[m
[31m-<!-- ## Friday, November 11th, 2016[m
[31m-[m
[31m-| Time   | Event                                   |[m
[31m-|:-------|:----------------------------------------|[m
[31m-| 2:30pm | Deadline for Project Idea to Instructor |[m
[31m-[m
[31m-## Thursday, November 17th, 2016[m
[31m-[m
[31m-**Presentations will begin at 1:30pm.**[m
[31m-[m
[31m-You are allowed to bring your laptop to the presentations -- we encourage you to Slack questions and comments about the presentations while they're happening! You are not, however, allowed to work on your projects at that time, out of respect for your classmates.[m
[31m-[m
[31m-| Time          | Event                                             |[m
[31m-|:--------------|:--------------------------------------------------|[m
[31m-| 12:00pm        | **[Presentation Video](./presentations.md) due** |[m
[31m-| 2:00 - 4:00 pm | [Project Presentations - Watch Videos Here](./wdi13_presentation_videos.md)      |[m
[31m-| 2:00 - 2:40 pm | 1st Round of Videos && 10 minute break                   |[m
[31m-| 2:40 - 3:20 pm | 2nd Round of Videos && 10 minute break                   |[m
[31m-| 3:20 - 3:50 pm | 3rd Round of Videos             |[m
[31m-| 3:50 - 4:00 pm | Non-ominous surprise |[m
[31m-| 4:00 - 4:30 pm | Squad Retros && Envelopes |[m
[31m-| 4:30 - 5:00 pm | Mid Course Feedback |[m
[31m- -->[m
[1mdiff --git a/tmp/cache/assets/sprockets/v3.0/Bx/BxzoG0KxeNLac4xTNeJv3qfeytbNBw58xj2zD-xdbrE.cache b/tmp/cache/assets/sprockets/v3.0/Bx/BxzoG0KxeNLac4xTNeJv3qfeytbNBw58xj2zD-xdbrE.cache[m
[1mindex a6ff7e8..93a1766 100644[m
Binary files a/tmp/cache/assets/sprockets/v3.0/Bx/BxzoG0KxeNLac4xTNeJv3qfeytbNBw58xj2zD-xdbrE.cache and b/tmp/cache/assets/sprockets/v3.0/Bx/BxzoG0KxeNLac4xTNeJv3qfeytbNBw58xj2zD-xdbrE.cache differ
[1mdiff --git a/tmp/cache/assets/sprockets/v3.0/G0/G0kukI-r0q0Vbrg6e_jnYJoYcOX8K__h-mwKbCf4twE.cache b/tmp/cache/assets/sprockets/v3.0/G0/G0kukI-r0q0Vbrg6e_jnYJoYcOX8K__h-mwKbCf4twE.cache[m
[1mindex b2b5b81..29b8feb 100644[m
Binary files a/tmp/cache/assets/sprockets/v3.0/G0/G0kukI-r0q0Vbrg6e_jnYJoYcOX8K__h-mwKbCf4twE.cache and b/tmp/cache/assets/sprockets/v3.0/G0/G0kukI-r0q0Vbrg6e_jnYJoYcOX8K__h-mwKbCf4twE.cache differ
[1mdiff --git a/tmp/cache/assets/sprockets/v3.0/Ya/YayMISAqD-Y3vBFywwKrXbUovGf5o77HUF5s8mnQgO0.cache b/tmp/cache/assets/sprockets/v3.0/Ya/YayMISAqD-Y3vBFywwKrXbUovGf5o77HUF5s8mnQgO0.cache[m
[1mindex df9919e..564b1fb 100644[m
Binary files a/tmp/cache/assets/sprockets/v3.0/Ya/YayMISAqD-Y3vBFywwKrXbUovGf5o77HUF5s8mnQgO0.cache and b/tmp/cache/assets/sprockets/v3.0/Ya/YayMISAqD-Y3vBFywwKrXbUovGf5o77HUF5s8mnQgO0.cache differ
[1mdiff --git a/tmp/cache/assets/sprockets/v3.0/dm/dmsQdzCXgEcSjxCQALgsqvDSMhzF72XWEBAxU7XqPhI.cache b/tmp/cache/assets/sprockets/v3.0/dm/dmsQdzCXgEcSjxCQALgsqvDSMhzF72XWEBAxU7XqPhI.cache[m
[1mindex a420eb1..a8ca5fd 100644[m
Binary files a/tmp/cache/assets/sprockets/v3.0/dm/dmsQdzCXgEcSjxCQALgsqvDSMhzF72XWEBAxU7XqPhI.cache and b/tmp/cache/assets/sprockets/v3.0/dm/dmsQdzCXgEcSjxCQALgsqvDSMhzF72XWEBAxU7XqPhI.cache differ
[1mdiff --git a/tmp/cache/assets/sprockets/v3.0/hk/hkwBL9FDcSlcR--5UFk6ERKHu9pj1GOBtDgaBd-V_c0.cache b/tmp/cache/assets/sprockets/v3.0/hk/hkwBL9FDcSlcR--5UFk6ERKHu9pj1GOBtDgaBd-V_c0.cache[m
[1mindex 012a1e3..acbed07 100644[m
Binary files a/tmp/cache/assets/sprockets/v3.0/hk/hkwBL9FDcSlcR--5UFk6ERKHu9pj1GOBtDgaBd-V_c0.cache and b/tmp/cache/assets/sprockets/v3.0/hk/hkwBL9FDcSlcR--5UFk6ERKHu9pj1GOBtDgaBd-V_c0.cache differ
[1mdiff --git a/tmp/cache/assets/sprockets/v3.0/x7/x7PYh8DJvPykcEqpVab2vcY9-GFz-3cqtoMlRAu94Uc.cache b/tmp/cache/assets/sprockets/v3.0/x7/x7PYh8DJvPykcEqpVab2vcY9-GFz-3cqtoMlRAu94Uc.cache[m
[1mindex f4149f6..3a3bd99 100644[m
Binary files a/tmp/cache/assets/sprockets/v3.0/x7/x7PYh8DJvPykcEqpVab2vcY9-GFz-3cqtoMlRAu94Uc.cache and b/tmp/cache/assets/sprockets/v3.0/x7/x7PYh8DJvPykcEqpVab2vcY9-GFz-3cqtoMlRAu94Uc.cache differ
[1mdiff --git a/wdi11_presentation_videos.md b/wdi11_presentation_videos.md[m
[1mdeleted file mode 100644[m
[1mindex 1ad75e4..0000000[m
[1m--- a/wdi11_presentation_videos.md[m
[1m+++ /dev/null[m
[36m@@ -1,28 +0,0 @@[m
[31m-# Videos[m
[31m-[m
[31m-```ruby[m
[31m-names.shuffle[m
[31m-```[m
[31m-[m
[31m-- [Dani](https://www.youtube.com/watch?v=kVdKlufM22w&feature=youtu.be) +[m
[31m-- [Jacqui](https://www.youtube.com/watch?v=S-9oysXLZCg&feature=youtu.be) +[m
[31m-- [Pamela](https://www.youtube.com/watch?v=WeLsppUcSvE)[m
[31m-- [Nelly](https://www.youtube.com/watch?v=_I4ai5k92Mg&feature=youtu.be) +[m
[31m-- [Ben](https://www.youtube.com/watch?v=xGWxqjeQEO8&feature=youtu.be)[m
[31m-- [Chase](https://www.youtube.com/watch?v=RkTM0URG-a8&feature=youtu.be)[m
[31m-- [Winston](https://www.youtube.com/watch?v=-i1PM3vf_f0&feature=youtu.be)[m
[31m-- [Rasheeda](https://www.youtube.com/watch?v=FkjtRdVkUBE&feature=youtu.be)[m
[31m-- [Evan](https://www.youtube.com/watch?v=x-5ndtlYElY) +[m
[31m-- [Chris](https://www.youtube.com/watch?v=Rx8PYRTCP00&feature=youtu.be) +[m
[31m-- [Tyler](https://www.youtube.com/watch?v=kUztUIcL-XU&feature=youtu.be) +[m
[31m-- [Van](https://www.youtube.com/watch?v=Qu32mkzVTZs&feature=youtu.be)  +[m
[31m-- [Sarah](https://www.youtube.com/watch?v=HxbYLOMbS-g&feature=youtu.be)[m
[31m-- [Marc](https://www.youtube.com/watch?v=tADQfjdbHno) +[m
[31m-- [Aubrey](https://www.youtube.com/watch?v=z_FHEHxOX18&feature=youtu.be) +[m
[31m-- [Megan](https://www.youtube.com/watch?v=kQqRfvS-nCc)[m
[31m-- [Taylor](https://www.youtube.com/watch?v=wCYQ2dApwGA&feature=youtu.be) +[m
[31m-- [Alex](https://www.youtube.com/watch?v=nRyIdmUjSos) +[m
[31m-- [Michael](https://www.youtube.com/watch?v=RJ2yd_Z9EBc&feature=youtu.be&hd=1) +[m
[31m-- [Ahmed](https://www.youtube.com/watch?v=EkVAFrWGP4E&feature=youtu.be) +[m
[31m-- [John]()[m
[31m-- [Gio]()[m
[1mdiff --git a/wdi13_presentation_videos.md b/wdi13_presentation_videos.md[m
[1mdeleted file mode 100644[m
[1mindex e52c1a1..0000000[m
[1m--- a/wdi13_presentation_videos.md[m
[1m+++ /dev/null[m
[36m@@ -1,20 +0,0 @@[m
[31m-Presentation Schedule:[m
[31m-[m
[31m-- [Bradley](https://www.youtube.com/watch?v=_Cciyn1E4B0&feature=youtu.be)[m
[31m-- [Angel](https://www.youtube.com/watch?v=aLZDncAyGTw&feature=youtu.be)[m
[31m-- [Diana](https://www.youtube.com/watch?v=96ye9LZcn_w&feature=youtu.be)[m
[31m-- [Jonathan G](https://www.youtube.com/watch?v=cCIKvtQLQTo&feature=youtu.be)[m
[31m-- [Donovan](https://www.youtube.com/watch?v=oVM7jsoPr3Q&feature=youtu.be)[m
[31m-- [Ba](https://www.youtube.com/watch?v=9Fjvy66_vso&feature=youtu.be)[m
[31m-- [Sam](https://www.youtube.com/watch?v=gawXH_18GKc&feature=youtu.be)[m
[31m-- [Juliett](https://www.youtube.com/watch?v=BU1xkF1LVS0&feature=youtu.be)[m
[31m-- [Rob R](https://www.youtube.com/watch?v=q6Lux3Cx0us&feature=youtu.be)[m
[31m-- [Kevin](https://www.youtube.com/watch?v=uLbbiuMOqcg&feature=youtu.be)[m
[31m-- [Drew](https://www.youtube.com/watch?v=IUsxmFmZQD0&feature=youtu.be)[m
[31m-- [EJ](https://www.youtube.com/watch?v=AOcPbPXexOM&feature=youtu.be)[m
[31m-- [Adrienne](https://www.youtube.com/watch?v=ZMMEOKasPzI&feature=youtu.be)[m
[31m-- [Jonathan R](https://www.youtube.com/watch?v=TjT2qnLfynY&feature=youtu.be)[m
[31m-- [Thinh](https://www.youtube.com/watch?v=pdHyU-WvUw0)[m
[31m-- [Rob K](https://vimeo.com/191955890)[m
[31m-- [Rob Z](https://www.youtube.com/watch?v=yKIqK5U67Tc&feature=em-upload_owner)[m
[31m-[m
[1mdiff --git a/wdi5_presentation_videos.md b/wdi5_presentation_videos.md[m
[1mdeleted file mode 100644[m
[1mindex 53e7b70..0000000[m
[1m--- a/wdi5_presentation_videos.md[m
[1m+++ /dev/null[m
[36m@@ -1,108 +0,0 @@[m
[31m-# Example Presentations[m
[31m-[m
[31m-These were recorded during the last cohort's final project.[m
[31m-[m
[31m-- Diana J[m
[31m-  - BestFesties[m
[31m-  - http://youtu.be/OR7pv4Rgw-A[m
[31m-- Nabil H[m
[31m-  - A Nice Nest[m
[31m-  - https://youtu.be/zsLdL-PCvhk[m
[31m-- Keith K[m
[31m-  - Keith's Kookbook[m
[31m-  - https://www.youtube.com/watch?v=D_IZJdUIPEA[m
[31m-- John M[m
[31m-  - Life Designer[m
[31m-  - https://youtu.be/pvZ46GP54zo[m
[31m-- Zakk F[m
[31m-  - Stor.io, Agile Project Management[m
[31m-  - https://www.youtube.com/watch?v=pp-b4tXh4Vk[m
[31m-- Lindsey D[m
[31m-  - Escape the Call[m
[31m-  - https://www.youtube.com/watch?v=s60V5gEp-Mg[m
[31m-- Janice M[m
[31m-  - Breakup Buddy[m
[31m-  - https://www.youtube.com/watch?v=HSR0FOLLASI[m
[31m-- Brad F[m
[31m-  - Barley[m
[31m-  - https://www.youtube.com/watch?v=7WuvZuLlug0[m
[31m-- Tamara P[m
[31m-  - Domestic Abuse Awareness[m
[31m-  - https://vimeo.com/129851158[m
[31m-- Brittany H[m
[31m-  - Quiz Game[m
[31m-  - https://www.youtube.com/watch?v=h-3udy8V_N8[m
[31m-- Isa C[m
[31m-  - CoverCreate[m
[31m-  - https://www.youtube.com/watch?v=DNg0fr6erRc[m
[31m-- Kevin B[m
[31m-  - MeetTheTeam[m
[31m-  - http://youtu.be/dgNMqzf-YS8[m
[31m-- Sarah G[m
[31m-  - goTogether[m
[31m-  - http://youtu.be/p4pOQIxxxqs[m
[31m-- Gwen M[m
[31m-  - PlayDate[m
[31m-  - http://youtu.be/TtdoYG-DtWA[m
[31m-- Haleigh H[m
[31m-  - TickeTush[m
[31m-  - https://www.youtube.com/watch?v=fRzWW-8zAbU[m
[31m-- Ryan K[m
[31m-  - Guns n' Rocks[m
[31m-  - https://www.youtube.com/watch?v=KpUrORiRLGQ[m
[31m-- Jocelyn J[m
[31m-  - NoizeBox[m
[31m-  - https://youtu.be/i_5N5IYoovU[m
[31m-- Julia R[m
[31m-  - LectureSpecter[m
[31m-  - https://youtu.be/SjJABON8mTM[m
[31m-- Ali T[m
[31m-  - I-Like[m
[31m-  - https://www.youtube.com/watch?v=PMxVOH5b2-c[m
[31m-- Preston S[m
[31m-  - Get Out and Play[m
[31m-  - https://www.youtube.com/watch?v=l8iL9hNaMq4[m
[31m-- Damon E[m
[31m-  - TravelPlanner[m
[31m-  - https://www.youtube.com/watch?v=u2sN4Gmgae8[m
[31m-- Don M and Nic S[m
[31m-  - Writers Hub[m
[31m-  - https://www.youtube.com/watch?v=1SOPgFh8IGM[m
[31m-- Parmeet S[m
[31m-  - Money Never Sleeps[m
[31m-  - https://www.youtube.com/watch?v=1-akNzCeTeg[m
[31m-- Noah L[m
[31m-  - Scrawl[m
[31m-  - https://www.youtube.com/watch?v=CUx8YLweWDU[m
[31m-- Allyson L[m
[31m-  - TruFlo[m
[31m-  - https://www.youtube.com/watch?v=6N5Z-ikE0Xs[m
[31m-- Enoch S[m
[31m-  - Portfolio Guard[m
[31m-  - https://youtu.be/FGnZ27kMuEY[m
[31m-- Nick B[m
[31m-  - Img2Map[m
[31m-  - https://www.youtube.com/watch?v=3TgJtAW8WHc[m
[31m-- Adrian M[m
[31m-  - Bandwagon[m
[31m-  - https://www.youtube.com/watch?v=y-EwQYhoQJU[m
[31m-- Toby S and Jared Y[m
[31m-  - Restofy[m
[31m-  - https://www.youtube.com/watch?v=BgJW_PlGe2w[m
[31m-- Eltahir E[m
[31m-  - https://www.youtube.com/watch?v=Mz3p3DuMjS8[m
[31m-- Biboy[m
[31m-  - https://www.youtube.com/watch?v=0dNNXj6lM8g&feature=youtu.be[m
[31m-- Phil[m
[31m-  - Journey[m
[31m-  - https://youtu.be/T-8xWSDH61A[m
[31m-- Ammie[m
[31m-  - https://www.youtube.com/watch?v=tsbr4GbZMSM[m
[31m-- Michael K[m
[31m-  - https://youtu.be/BsfgcXI6-Wg[m
[31m-- Matt W[m
[31m-  - http://youtu.be/-1TvrkcZzAI[m
[31m-- Aaron P[m
[31m-  - https://www.youtube.com/watch?v=RkOAmD4UEIs[m
[31m-- Tyler B[m
[31m-  - https://www.youtube.com/watch?v=6VfarjoFYmM[m
\ No newline at end of file[m
[1mdiff --git a/wdi6_presentation_videos.md b/wdi6_presentation_videos.md[m
[1mdeleted file mode 100644[m
[1mindex 2f3193f..0000000[m
[1m--- a/wdi6_presentation_videos.md[m
[1m+++ /dev/null[m
[36m@@ -1,49 +0,0 @@[m
[31m-# Videos[m
[31m-- [Jared A](https://youtu.be/iY3C-8cyIkk)[m
[31m-- [Walter A](https://www.youtube.com/watch?v=_fnNbRrMek0)[m
[31m-- [Erik A](https://www.youtube.com/watch?v=WBDzAv4_QW0&feature=youtu.be)[m
[31m-- [Erica A](https://vimeo.com/135635083)[m
[31m-- [Silvia B](https://www.youtube.com/watch?v=Nva1N6kCIN8&feature=youtu.be)[m
[31m-- [Tom B](https://vimeo.com/135632893)[m
[31m-- [Robert B](https://www.youtube.com/watch?v=3b1ZQYXR7LY)[m
[31m-- [Alex B](https://www.youtube.com/watch?v=7Or0N7yewAA)[m
[31m-- [Matt C](https://www.youtube.com/watch?v=r2Z1wb13WoI&feature=youtu.be)[m
[31m-- [Peter C](https://vimeo.com/135626640)[m
[31m-- [Kevin C](https://vimeo.com/135631139)[m
[31m-- [Mike D](https://youtu.be/cHL-dTYmMoA)[m
[31m-- [Preston D](http://youtu.be/YEX-gR_jk_4)[m
[31m-- [Karl D](https://www.youtube.com/watch?v=UKYUaxkQbW4)[m
[31m-- [Paul D](https://www.youtube.com/watch?v=jMIVmezM8kk&feature=youtu.be)[m
[31m-- [Phil E](https://www.youtube.com/watch?v=5uDp8VasRCg)[m
[31m-- [Matt F](http://youtu.be/TZazD9lnxuQ)[m
[31m-- [Cameron F](https://youtu.be/BxwiZQ1Kk_M)[m
[31m-- [Kristin G](http://youtu.be/Bi270ZJkjUQ)[m
[31m-- [Stephen G](http://youtu.be/IP_5bRflrf0)[m
[31m-- [Mostafa H](https://www.youtube.com/watch?v=tEodYwHQ950&feature=youtu.be)[m
[31m-- [Erica I](http://youtu.be/Zp3AWSJdtxU)[m
[31m-- [Jeff J](https://www.youtube.com/watch?v=pxgspBMolk0&feature=youtu.be)[m
[31m-- [Taewan K](https://www.youtube.com/watch?v=OZfAQVGgBfQ)[m
[31m-- [Sam K](https://www.youtube.com/watch?v=8ZnvUBq0kcg)[m
[31m-- [Ryan K](https://www.youtube.com/watch?v=VwIO1i7PXGA&feature=youtu.be)[m
[31m-- [Jeremy K](https://youtu.be/evhKHwyFUpA)[m
[31m-- [Lana K](http://youtu.be/uXQMQLqlzH8)[m
[31m-- [Christine L](https://vimeo.com/135624629)[m
[31m-- [John M](https://youtu.be/J65vi9mkB2c)[m
[31m-- [Anand M](https://youtu.be/wEthevAEz4E)[m
[31m-- [Cheikh N](http://youtu.be/DnmjDtS8kjM)[m
[31m-- [Nick O](https://youtu.be/_f0TqbFLgJs)[m
[31m-- [Justin P](https://youtu.be/aGlaDFQvXtg)[m
[31m-- [Eddie P](https://www.youtube.com/watch?v=fCVe31G_Kto&feature=youtu.be)[m
[31m-- [Rosel P](https://youtu.be/i0762LK9AR8)[m
[31m-- [Lon P](http://youtu.be/YUlpFcEy9n0)[m
[31m-- [Malissa R](https://youtu.be/OQrEs_U3jhc)[m
[31m-- [Laura N](http://youtu.be/6xT5tiIZNJ4)[m
[31m-- [Ksenia C](https://youtu.be/VXzvubrKStk)[m
[31m-- [Omari M](https://youtu.be/7V1qN4hg9Pk)[m
[31m-- [Arash S](https://www.youtube.com/watch?v=t9YsRogO8S0)[m
[31m-- [Melissa S](https://www.youtube.com/watch?v=p9XcmIQslpQ&feature=youtu.be)[m
[31m-- [Lisa S](http://youtu.be/m3yJKUI9nvk)[m
[31m-- [Adrian S](http://youtu.be/X0Q0LsmiGag)[m
[31m-- [Leigh V](https://youtu.be/Ov3rY2EtU5w)[m
[31m-- [Rachel W](https://youtu.be/KV-lujD3gq8)[m
[31m-- [Yvonne W](https://youtu.be/Nm89-IpSxRk)[m
[1mdiff --git a/wdi7_presentation_videos.md b/wdi7_presentation_videos.md[m
[1mdeleted file mode 100644[m
[1mindex b89e871..0000000[m
[1m--- a/wdi7_presentation_videos.md[m
[1m+++ /dev/null[m
[36m@@ -1,66 +0,0 @@[m
[31m-# Videos[m
[31m-[m
[31m-## CR 1[m
[31m-- [Jordan B](https://youtu.be/k0vrkt3ZshI)[m
[31m-- [Tory B](https://youtu.be/5g9l4Wy6nWk)[m
[31m-- [Shawn C](https://youtu.be/iyq3yhrQrT8)[m
[31m-- [Kory C](https://youtu.be/n9Ij2QlK8lw)[m
[31m-- [Starr C](https://vimeo.com/sipofstarrshine/gobblr)[m
[31m-- [Thomas C](https://youtu.be/Y_YOX4C3jSA)[m
[31m-- [Josh C](https://www.youtube.com/watch?v=bong7TdNvsQ)[m
[31m-- [Tyler C](https://youtu.be/U9797AwZW84)[m
[31m-- [Wonsik J](https://www.youtube.com/watch?v=HvtmCo98n9g&feature=youtu.be)[m
[31m-- [Alexis J](https://www.youtube.com/watch?v=DbKaucDf9z8&feature=youtu.be)[m
[31m-- [Andrew J](https://youtu.be/eQD_pMZIi64)[m
[31m-- [Elise K](https://vimeo.com/146351674)[m
[31m-- [Negar K](https://youtu.be/2hxaLOyUe8o)[m
[31m-- [Teddy K]()[m
[31m-- [J Moon](https://youtu.be/9pGE7usy8Fk)[m
[31m-- [Matt M](https://youtu.be/w2sv41jC6QY)[m
[31m-- [Ly N](https://youtu.be/gljZMWlufWg)[m
[31m-- [Jared N](https://youtu.be/AjXpgQ-_RWo)[m
[31m-- [John P](https://vimeo.com/146407349)[m
[31m-- [Jen P](https://www.youtube.com/watch?v=d7BWhb3rNYE)[m
[31m-[m
[31m-## CR 4[m
[31m-[m
[31m-- [Daniel](https://youtu.be/XwXj5B-cLko)[m
[31m-- [Alea](https://youtu.be/ATPRXITxcDA)[m
[31m-- [Davis](https://youtu.be/yUi4s70v96M)[m
[31m-- [Chase](https://vimeo.com/146390337)[m
[31m-- [Mia](https://www.youtube.com/watch?v=IulKaOCzOFw)[m
[31m-- [Thom](https://youtu.be/t137KS8Oolc)[m
[31m-- [Cassidy](https://www.youtube.com/watch?v=O1W8MmfYdjA)[m
[31m-- [Sarah](https://www.youtube.com/watch?v=eXAU_U-txmw)[m
[31m-- [Rachel](https://www.youtube.com/watch?v=Oa0SeCfCIh4)[m
[31m-- [Matt](https://vimeo.com/146405675)[m
[31m-- [Armani](https://youtu.be/Sxw3j6EATOE)[m
[31m-- [Markham](https://www.youtube.com/watch?v=4QE9xgNEKfY&feature=youtu.be)[m
[31m-- [Becky](http://www.youtube.com/watch?v=Yhs82IStMls)[m
[31m-- [Tim](https://youtu.be/3zG9rLCDrqA)[m
[31m-- [Kelly](https://vimeo.com/146415507)[m
[31m-- [Andre](https://www.youtube.com/watch?v=dfTu0m9cBHE&feature=youtu.be)[m
[31m-- [Aurelio](https://youtu.be/IKviZaKpGOM)[m
[31m-- [Chrystal](https://youtu.be/TgXkJYSPwGc)[m
[31m-- [Alex](https://www.youtube.com/watch?v=rOSgY5BUUwU)[m
[31m-- [Jorge](https://youtu.be/xAsAWEhZRtQ)[m
[31m-- [Mati](https://youtu.be/4C1Xxeu-bVg)[m
[31m-[m
[31m-## CR 5[m
[31m-- [Britton W](https://www.youtube.com/watch?v=mws-ltvsehM&feature=youtu.be)[m
[31m-- [Peter Z](https://www.youtube.com/watch?v=2JE2NFTtPsg)[m
[31m-- [Eric S](https://youtu.be/0DBcu-vcKAY)[m
[31m-- [Dennis T](https://youtu.be/6_jNkj7pPBs)[m
[31m-- [Thomas S](https://youtu.be/EyrqdqShnYI)[m
[31m-- [Qadriyyah T](https://youtu.be/ULcUpBbhojk)[m
[31m-- [Roshana D](https://github.com/ga-dc/project2/issues/453)[m
[31m-- [Rebecca E](https://youtu.be/Tl4IHAWDveo)[m
[31m-- [Alice F]( https://youtu.be/QU3-fTdoqpU)[m
[31m-- [Joe GZ](https://www.youtube.com/watch?v=u7D5A4q9eLU)[m
[31m-- [Moe G](https://www.youtube.com/watch?v=5N9B3L8JJec)[m
[31m-- [Dimitri](https://www.youtube.com/watch?v=tH17JguzvJU&feature=youtu.be)[m
[31m-- [Chris K](https://youtu.be/Ua4pjrz9LE0)[m
[31m-- [Brendan L](https://www.youtube.com/watch?v=zKxlfLlxmqs)[m
[31m-- [Bryce L](https://youtu.be/RVsxQzW67iU)[m
[31m-- [Brendan M](https://www.youtube.com/watch?v=y6ObYOAcvfE&feature=youtu.be)[m
[31m-- [Samir M](https://youtu.be/9vtt-ZA3WKs)[m
[1mdiff --git a/wdi9_presentation_videos.md b/wdi9_presentation_videos.md[m
[1mdeleted file mode 100644[m
[1mindex 3198626..0000000[m
[1m--- a/wdi9_presentation_videos.md[m
[1m+++ /dev/null[m
[36m@@ -1,17 +0,0 @@[m
[31m-# Videos[m
[31m-[m
[31m-* [jordan](https://www.youtube.com/watch?v=77dW8fJdTD4&feature=youtu.be)[m
[31m-* [matt](https://www.youtube.com/watch?v=b-ai0damwt8&feature=youtu.be)[m
[31m-* [hewan]()[m
[31m-* [martin](https://www.youtube.com/watch?v=o9956WzjkGc)[m
[31m-* [lauren]()[m
[31m-* [Zaneh](https://www.youtube.com/watch?v=-9VKaUEqg6c)[m
[31m-* [louis](https://youtu.be/6PoYdJt2HKc)[m
[31m-* [habby](https://www.youtube.com/watch?v=YcgfRNRLSu4&feature=youtu.be)[m
[31m-* [Leland](https://www.youtube.com/watch?v=IvynbFt4dEI&feature=youtu.be)[m
[31m-* [Wes](https://www.youtube.com/watch?v=7SWwt-acaVU&feature=youtu.be)[m
[31m-* [josh](https://www.youtube.com/watch?v=qd8rI1f0r9Q)[m
[31m-* [james](https://www.youtube.com/watch?v=EGnwJeEcDVI&feature=youtu.be)[m
[31m-* [mary](https://www.youtube.com/watch?v=fgBgCLQ4KrA&feature=youtu.be)[m
[31m-* [antony](https://www.youtube.com/watch?v=SsD4Sf8XrPs&feature=youtu.be)[m
[31m-* [mike](https://www.youtube.com/watch?v=BnyCI4YIlqs&feature=youtu.be)[m

```
