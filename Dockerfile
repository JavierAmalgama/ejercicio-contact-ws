FROM ruby:2.2
ENV RAILS_ENV=production

WORKDIR /usr/src/app
COPY . /usr/src/app

RUN bundle install --deployment --without deployment,development

CMD bin/run
