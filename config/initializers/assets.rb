# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( 
  teaspoon.css 
  mocha/1.17.1.js 
  teaspoon-mocha.js 
  teaspoon-teaspoon.js 
  support/sinon.js
  support/chai.js
  support/expect.js
  shared.css
)

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
