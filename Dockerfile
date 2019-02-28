FROM ruby:2.5.3
MAINTAINER sivakumar@spritle.com
RUN apt-get update  && apt-get install -y build-essential
#for postgres
RUN apt-get install -y libpq-dev
# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
RUN echo "US/Eastern" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
RUN curl -sL https://deb.nodesource.com/setup_8.x |  bash -
RUN  apt-get install -y nodejs
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install imagemagick libmagickcore-dev libmagickwand-dev -y
RUN gem install rmagick
ENV APP_HOME /app
ADD Gemfile* $APP_HOME/
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=4
WORKDIR $APP_HOME
RUN bundle install



