FROM ruby:2.4.2
ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y nodejs \
                       vim \
                       mysql-client \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

#Cache bundle install
RUN mkdir /chatsystem
WORKDIR /chatsystem
COPY ./Gemfile /chatsystem/
COPY ./Gemfile.lock /chatsystem/

RUN \
  gem update --system --quiet && \
  gem install  bundler -v '2.2.15'
ENV BUNDLER_VERSION 2.2.15
RUN bundle install
COPY . /chatsystem

CMD ["rails", "server"]
