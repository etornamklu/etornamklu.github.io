source "https://rubygems.org"

# Jekyll version
# Ensure compatibility with GitHub Pages if needed
gem "jekyll", "~> 3.9.5"

gem "no-style-please", "~> 0.4.7"

# Plugins
# GitHub Pages supports a limited set of plugins, but you can use others locally
group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.15"
  gem "jekyll-seo-tag", "~> 2.7"
  gem "webrick", "~> 1.9"
  gem "kramdown", "~> 2.5"
  gem "kramdown-parser-gfm"
end

# Ensure Windows compatibility
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# Performance booster for file watching on Windows
gem "wdm", "~> 0.1.0", install_if: Gem.win_platform?

# HTTP parser for JRuby
gem "http_parser.rb", "~> 0.6.0", platforms: [:jruby]
