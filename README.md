# About
This as a minimal example to run prometheus collecting data from itself, grafana visualizing data from prometheus and
both behind a nginx reverse proxy for SSL termination and basic auth.

This is based on
1. https://github.com/prometheus-community/prometheus-playground/tree/master/nginx
2. https://grafana.com/tutorials/run-grafana-behind-a-proxy/
3. https://github.com/grafana/grafana/issues/18299
4. https://community.grafana.com/t/after-update-to-8-3-5-origin-not-allowed-behind-proxy/60598

and just putting things together.


## Limitations
This setup is just meant to illustrate the basic setup and needs to be refined for production i.e. volumes for grafana
and prometheus should be mounted or certificates should be managed centrally.

# Usage
## Certificates
Create the required certificates. Adapt ```nginx/server_cert.conf``` or ```.env``` if required

```bash
# run from the main directory
./nginx/create_root_cert.sh
./nginx/create_server_cert.sh
```

Import the rootCA.crt in your browser.
## Basic Auth (Optional)
The default username and password for Basic Auth are:
username: admin
password: password

To change this run (assuming you are running a debian based distribution)
```bash
sudo apt-get install apache2-utils
htpasswd -c nginx/.htpasswd admin
```


## Run the setup

```bash
# run the setup
sudo docker compose up

# stop the setup
sudo docker compose down

# clean up the setup
sudo docker compose rm --stop --volumes
```

When the setup ist run you can access
1. grafana at https://localhost/grafana
2. prometheus at https://localhost/prometheus

both require the BasicAuth username and password defined in nginx/.htpasswd
grafana requires the initial username and password from grafana.ini (default: username: admin, password: admin)

