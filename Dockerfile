FROM ruby:3.1

# Set working directory
WORKDIR /usr/src/app

# Install Bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock first (to leverage Docker cache)
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Copy the rest of the application files
COPY . .

# Expose Jekyll's default port
EXPOSE 4000

# Serve Jekyll site
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
