# WPS - Work planning service

Hope you'll like it :)

Here's an overview of slices in Hanami framework: https://guides.hanamirb.org/v2.0/app/slices/

Therefore, most of the logic resides under `slices/main`.

## Testing

First, install the dependencies:

```
bundle install
```

This application uses PostgreSQL for persistence.

With Postgres running, create database for test using PostgreSQL’s `createdb` command:

```
createdb wps_test
```

Create `.env.test` file with DATABASE_URL ENV variable, poining to your database:

```
DATABASE_URL=postgres://postgres@localhost:5432/wps_test
```

Run migrations:

```
HANAMI_ENV=test bundle exec rake db:migrate
```

Finally,

```
bundle exec rspec
```
