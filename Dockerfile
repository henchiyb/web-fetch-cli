FROM ruby:3.0.3
ENV TZ=Asia/Tokyo

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.2.33
RUN bundle install

COPY . .

ENTRYPOINT [ "ruby", "fetch.rb" ]