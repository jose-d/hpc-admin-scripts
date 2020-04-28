regular repo sync can be configured in crontab:

```
 59    1     *   *    *        /repo/centos/sync.sh &> /var/log/repo_centos_sync.log
 
#*     *     *   *    *        command to be executed
#-     -     -   -    -
#|     |     |   |    |
#|     |     |   |    +----- day of week (0 - 6) (Sunday=0)
#|     |     |   +------- month (1 - 12)
#|     |     +--------- day of        month (1 - 31)
#|     +----------- hour (0 - 23)
#+------------- min (0 - 59)
```
