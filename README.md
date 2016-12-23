# medlang
Database and E-Learning platform for medical language in German and English
## Getting started
### Installations
I use MongoDB `3.0.9`, ruby `2.2.3` and ruby on rails `4.2.4`. I think that you can run medlang also with other versions of mongodb, ruby and RoR but I can't guarantee it.
### Run medlang
1. import the mongo dump from `medlang/medlang_data/dump` with `mongorestore` to your mongodb. If you don't have access to medlang_data, contact [us](http://eonum.ch/en/contact/). We will provide you with the data
2. create a `secrets.yml` file in your `config` folder. This file should look in a way like this:
   ```
    development:
      secret_key_base: insert your key here
    test:
      secret_key_base: insert your key here
    production:
      secret_key_base: insert your key here
   ```

   you can generate keys with `bundle exec rake secret`
3. Now you should be able to run medlang with `rails s`!


New information will drop in the README from time to time.

