# Jilion Backups

Made to run on the Heroku Cedar Stack, feel free to add more databases/archives to backup in `config.rb`

Launched via the Heroku Scheduler addon every day, but it can be launched manually with:

``` bash
heroku run backup
```

## Heroku Postgresql

Don't forget to add `backup@jilion.com` as member of the app you want to backup.

