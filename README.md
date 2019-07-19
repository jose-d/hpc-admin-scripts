# hpc-admin-scripts
Various scripts possibly usable when running HPC site

## scripts description:

### vnc-session-limiter

quick-n-dirty script checking if there is user having more than LIMIT of vnc sessions on particular node.
Sessions over limit are killed in order from the oldest.

Python3 and psutils used.

I have this script in root crontab shortly after midnight.
