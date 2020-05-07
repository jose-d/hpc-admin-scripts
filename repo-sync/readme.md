regular repo sync can be configured in crontab:

```
 59    1     *   *    *        /repo/centos/sync.sh &> /var/log/repo_centos_sync.log
 @daily                        /usr/bin/reposync --newest-only -l -q --delete --repoid='puppet6' --download_path=/repo/puppet/ && /usr/bin/createrepo /repo/puppet/puppet6 &> /var/log/repo_puppet6_sync.log
 @daily                        /usr/bin/reposync --newest-only -l -q --delete --repoid='docker-ce-stable' --download_path=/repo/docker/ && /usr/bin/createrepo /repo/docker/docker-ce-stable &> /var/log/repo_docker_ce_stable_sync.log
 @daily                        /usr/bin/reposync --newest-only -l -q --delete --repoid='OpenHPC' --download_path=/repo/openhpc/el7/ && /usr/bin/createrepo /repo/openhpc/el7/OpenHPC &> /var/log/repo_openhpc_sync.log
 @daily                        /usr/bin/reposync --newest-only -l -q --delete --repoid='OpenHPC-updates' --download_path=/repo/openhpc/el7/ && /usr/bin/createrepo /repo/openhpc/el7/OpenHPC-updates &> /var/log/repo_openhpc_updates_sync.log
 @daily                        /usr/bin/reposync --newest-only -q -l --delete --repoid='epel' --download_path=/repo/epel/7 && /usr/bin/createrepo /repo/epel/7/epel &> /var/log/repo_epel7_sync.log

#*     *     *   *    *        command to be executed
#-     -     -   -    -
#|     |     |   |    |
#|     |     |   |    +----- day of week (0 - 6) (Sunday=0)
#|     |     |   +------- month (1 - 12)
#|     |     +--------- day of        month (1 - 31)
#|     +----------- hour (0 - 23)
#+------------- min (0 - 59)
```
