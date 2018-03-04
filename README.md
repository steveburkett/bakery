Classroom Bakery
================

Classroom Bakery is an artisanal digital bakery, crafting the finest digital cookies in Bend Oregon

We don't mass produce our cookies in faceless factories. Instead, We bake cookies to order, one at a time.

Reference Application
---------------------
HTTP Auth access: bake / somecookies

Test Suite
----------

``
$ rspec spec
``

Database Seed Data
------------------

```
$ rake db:seed
```

Dependency Installation
------------------

```
$ brew install redis (and possibly configuration on aws or heroku)
$ bundle install
$ yarn install
```

Requirements
-------------

This application requires:

- Ruby 2.5.0
- PostgreSQL server
- Redis (running on port 6379)
