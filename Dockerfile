#This Tells Docker which Image to use, this is an official ruby image from docker
FROM ruby:2.6.3
#Update the repo listins in the container
RUN apt-get update
#Install Package into container
RUN apt-get install --assume-yes --no-install-recommends build-essential postgresql-client ca-certificates nodejs
#Specify the enviroment varible APP with the path
ENV APP /usr/src/app
#This makes directory for app
RUN mkdir -p $APP
#Tells container where we will be working from
WORKDIR $APP
#Copies gemfile and gemfile.lock to app folder
COPY Gemfile* $APP/
#Tells it to run bundle install on as many threads as avaible
RUN bundle install --jobs=$(nproc)
#Tells it to copy our code into the app folder
COPY . $APP/
#Tells the container to run migrations
CMD ["bin/rails","db:create"]
#Tells the container to run migrations
CMD ["bin/rails","db:migrate"]
#Tells the container to start rails server on port 3000 and bind to wildcard ip
CMD ["bin/rails", "server", "-p", "3000", "-b", "0.0.0.0"]