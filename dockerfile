FROM ruby:3.1

# 安装系统依赖
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev libmysqlclient-dev nodejs yarn imagemagick

WORKDIR /app

# 复制 Gemfile 和 Gemfile.lock
COPY Gemfile Gemfile.lock ./

# 安装 Bundler 及依赖
RUN gem install bundler && bundle install --without development test

# 复制全部源码
COPY . .

# 预编译静态资源
RUN bundle exec rake generate_secret_token
RUN RAILS_ENV=production bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-e", "production", "-b", "0.0.0.0"]