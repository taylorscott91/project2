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
diff --git a/app/controllers/games_controller.rb b/app/controllers/games_controller.rb
index c24460e..b272340 100644
--- a/app/controllers/games_controller.rb
+++ b/app/controllers/games_controller.rb
@@ -15,27 +15,30 @@ class GamesController < ApplicationController
   def create
     @group = Group.find(params[:group_id])
     @group.games.create(game_params)
-  #  @game = Game.create!(game_params)
+    # You are already assigning a group_id to the new game by using @group.games.create

-    redirect_to group_games_path(@group)
+    redirect_to group_path(@group)
   end

   #show
   def show
+    @group = Group.find(params[:group_id])
     @game = Game.find(params[:id])
   end

   # edit
   def edit
+    @group = Group.find(params[:group_id])
     @game = Game.find(params[:id])
   end

   # update
   def update
+    @group = Group.find(params[:group_id])
     @game = Game.find(params[:id])
     @game.update(game_params)

-    redirect_to games_path(@game)
+    redirect_to group_game_path(@group,@game)
   end

   # destroy
@@ -48,6 +51,8 @@ class GamesController < ApplicationController

   private
   def game_params
-    params.require(:game).permit(:name, :url, :group_id)
+    params.require(:game).permit(:name)
+    # This only filters out what can be submitted via form data. You only need to
+    # allow in :name
   end
 end
diff --git a/app/views/games/edit.html.erb b/app/views/games/edit.html.erb
index c444235..f7a074d 100644
--- a/app/views/games/edit.html.erb
+++ b/app/views/games/edit.html.erb
@@ -1,15 +1,15 @@
 <h2>Edit Game</h2>

-<%= form_for @game do |f| %>
-  <%= f.label :title %>
-  <%= f.text_field :title %>
-
+<%= form_for [@group, @game] do |f| %>
+  <%= f.label :name %>
+  <%= f.text_field :name %>
+  <%# The attributes on a form_for must match those of the model it is creating / editing %>
   <%= f.label :group_id %>
   <%= f.text_field :group_id %>

   <%= f.submit %>
 <% end %>

-<%= form_for @game, method: :delete do |f| %>
+<%= form_for [@group, @game], method: :delete do |f| %>
   <%= f.submit "Delete!", class: "delete" %>
 <% end %>
diff --git a/app/views/games/new.html.erb b/app/views/games/new.html.erb
index 0a64dc2..b7a20f8 100644
--- a/app/views/games/new.html.erb
+++ b/app/views/games/new.html.erb
@@ -1,11 +1,13 @@
 <h2>New Game</h2>

 <%= form_for [@group, @game] do |f| %>
-  <%= f.label :title %>
-  <%= f.text_field :title %>
-
+  <%= f.label :name %>
+  <%= f.text_field :name %>
+  <%# The error on new was because :title should be :name to match the attribute on the schema %>
   <%= f.label :group_id %>
   <%= f.text_field :group_id %>
-
+  <%# You do not need a field for :group_id since you can do it in the controller's create action
+  by querying params for which group the game is being created in. Look in the controller for
+  an example of this %>
   <%= f.submit %>
 <% end %>
diff --git a/app/views/games/show.html.erb b/app/views/games/show.html.erb
index 245b78e..f221ef8 100644
--- a/app/views/games/show.html.erb
+++ b/app/views/games/show.html.erb
@@ -1,2 +1,2 @@
-<h2><%= @game.title %> <%= link_to "(edit)", edit_group_game_path(@game.group, @game) %></h2>
-<h3>By: <%= @game.group.name %></h3>
+<h2><%= @game.name %> <%= link_to "(edit)", edit_group_game_path(@group, @game) %></h2>
+<h3>By: <%= @group.name %></h3>
diff --git a/app/views/groups/show.html.erb b/app/views/groups/show.html.erb
index 6984b7c..d31548b 100644
--- a/app/views/groups/show.html.erb
+++ b/app/views/groups/show.html.erb
@@ -7,7 +7,7 @@
 <ul>
   <% @group.games.each do |game| %>
     <li>
-      <%= group_game_path(@group, game) %>
+      <%= link_to game.name, group_game_path(@group, game) %>
     </li>
   <% end %>
 </ul>
diff --git a/app/views/layouts/application.html.erb b/app/views/layouts/application.html.erb
index 41df9b7..9300d35 100644
--- a/app/views/layouts/application.html.erb
+++ b/app/views/layouts/application.html.erb
@@ -10,6 +10,10 @@
   </head>

   <body>
+    <%# You may want to consider adding a nav bar here to house a link to the home page %>
+    <nav>
+      <%= link_to "Home", root_path %>
+    </nav>
     <header><img src="https://wallpaperbrowse.com/media/images/the-games-logo.jpg"></header>
     <h1>Collect.       Trade.       Play.</h1>

diff --git a/config/routes.rb b/config/routes.rb
index 73ffb83..93dee71 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -1,6 +1,6 @@
 Rails.application.routes.draw do
   root to: 'groups#index'
-
+  # Good setup of root route and nesting resources
   resources :groups do
     resources :games
   end
diff --git a/db/migrate/20170302051926_create_games.rb b/db/migrate/20170302051926_create_games.rb
index 040544d..a3c5620 100644
--- a/db/migrate/20170302051926_create_games.rb
+++ b/db/migrate/20170302051926_create_games.rb
@@ -5,4 +5,6 @@ class CreateGames < ActiveRecord::Migration[5.0]
       t.integer :group_id
     end
   end
+  # Consider adding more attributes to your Game model here. Things such as a description,
+  # release year, number of players, etc.
 end
diff --git a/db/seeds.rb b/db/seeds.rb
index 67af464..88aaeb6 100644
--- a/db/seeds.rb
+++ b/db/seeds.rb
@@ -17,3 +17,13 @@ Game.create(name: "Destiny", group_id: 3)
 Game.create(name: "Betrayal at House on the Hill", group_id: 1)
 Game.create(name: "Takenoko", group_id: 1)
 Game.create(name: "Fluxx", group_id: 2)
+
+# Always use bang (!) operators on .create!() to force potential errors to print to the terminal
+# When creating mutliple instances of a given model, you can use an array syntax:
+#
+# Game.create!([
+#   {name: "Destiny", group_id: 3},
+#   {name: "Betrayal at House on the Hill", group_id: 1},
+#   {name: "Takenoko", group_id: 1},
+#   {name: "Fluxx", group_id: 2}
+# ])
```
