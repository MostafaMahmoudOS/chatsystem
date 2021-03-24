# ChatSystem

Chatsystem is system make you (as client entity ) to create your chat application and add many chats under your application scope and add chat members (as user entity) .

## Features

- Client can create many Applictions and edit old one
- Client can create chat with users as memeber in his application 
- Client can create chat and list or edit any chat in his application
- User as chat member can post message 


## Installation

ChatSystem requires Docker and rails v5 to run.

```sh
cp config/database.yml.example config/database.yml
docker build .
docker-compose run web bundle install
docker-compose run web rake db:create
docker-compose run web rails db:setup
docker-compose build
docker-compose up
```

## APIs

Import Chat system.postman_collection.json file in Postman as collection.

## Database design

show DB_ERD.png