# Rails Engine

## Description 
This project showcases custom assembled JSON API endpoints which expose data imported from the [sales engine](https://github.com/turingschool-examples/sales_engine/tree/master/data) CSV file. It also utilizes PostgresQL and ActiveRecord to compile business intelligence information.

## Access Rails Engine Locally 

#### Access Locally
* Clone this repo with: `git clone git@github.com:Capleugh/rails_engine.git`
* Install Ruby 2.4.1
* Install Rails 5.1.7
* Run `$ bundle install`
* Run `$ rails db:setup`
* This application uses the following gems for testing, which are included in the gemfile:
   * `fast_jsonapi`
   * `rspec-rails`
   * `capybara`
   * `shoulda-matchers`
   * `factory_bot_rails`
   * `faker`
   
## Schema 
![alt text](rails_engine (1).pdf)

## Built With
* Ruby on Rails - web framework (version)
* PostgresQL - database manager
* [Fast JSON API](https://github.com/Netflix/fast_jsonapi/blob/master/performance_methodology.md) 

