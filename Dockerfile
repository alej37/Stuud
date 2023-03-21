FROM ruby:3.0.2
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn
WORKDIR /Stuud
COPY . .
COPY Gemfile ./Gemfile
RUN rm -rf ./Gemfile.lock
RUN bundle install
RUN yarn install
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

