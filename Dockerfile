FROM ruby:3.2.2

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
    ffmpeg

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install

COPY . /usr/src/app/

CMD ["ruby", "start_bot.rb"]