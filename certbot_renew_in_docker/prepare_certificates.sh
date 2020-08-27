#!/bin/bash

# this script maintains /etc/certbotcerts - equivalent of /etc/letsencrypt
# vanilla docker certbot from doker hub used.
# to be executed from cron weekly (as recommended by ${community} here:
# *  https://community.letsencrypt.org/t/how-often-should-i-run-the-cerbot-cron-job-to-update-the-certificates/18851

export certbot_port=3081

function verify_domain () {

  SITE=$1
  DOMAIN=$2
  ADMINMAIL=$3

  echo "trying to verify ${SITE}.${DOMAIN} on behalf of ${ADMINMAIL}."

  fulldomain="${SITE}.${DOMAIN}"

  certdir="/etc/certbotcerts/${SITE}"
  mkdir -p ${certdir}

  # --force-renewal # the force-remewal can be uncommented if needed...
  out=$(docker run --rm -it -v ${certdir}:/etc/letsencrypt -p ${certbot_port}:3081 certbot/certbot certonly --authenticator standalone --http-01-address=0.0.0.0 --http-01-port=3081 -d ${fulldomain} --non-interactive --agree-tos --email ${ADMINMAIL})
  rc="$?"
  echo "rc: $rc"
  echo "out: $out"
  
  if [[ $out == *"Certificate not yet due"* ]]; then
    echo "certificate is not yet due"
  else
    echo "restarting haproxy"
    systemctl restart haproxy_docker.service
  fi

  # haproxy needs key and cert in one file. So we'll create it:
  key_and_cert_dir="${certdir}/live/${fulldomain}"
  rm -rf ${key_and_cert_dir}/key_and_cert.pem
  cat ${key_and_cert_dir}/fullchain.pem ${key_and_cert_dir}/privkey.pem >> ${key_and_cert_dir}/key_and_cert.pem

}

# main()

# verify domains:

verify_domain "grafana" "ceico.cz" "jose@fzu.cz"
verify_domain "jh1" "ceico.cz" "jose@fzu.cz"

