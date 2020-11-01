# Gotify-Nextcloud

[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

A Python script that fetches notifications from the Nextcloud notification API and pushes them to a Gotify server.

## Usage

Just adapt the settings in the settings.py file and start run the script.
A working Nextcloud instance and a working Gotify setup is needed.

### Docker

#### Building the image

Build the image with the following command. Do not forget the `.` (dot) from the end!

```sh
docker build --no-cache -t gotify-nextcloud:latest .
```

#### docker cli

Example command:

```sh
docker run -d \
  --name=gotify-nextcloud \
  -e NEXTCLOUD_URL=https://nextcloudexample.com \
  -e NEXTCLOUD_USER=user \
  -e NEXTCLOUD_PASSWORD=secretpw \
  -e GOTIFY_URL=https://gotifyexample.com \
  -e GOTIFY_TOKEN=TOKEN \
  --restart unless-stopped \
  gotify-nextcloud:latest
```

#### docker-compose ([recommended](https://docs.docker.com/compose/))

You can use environment variables, `.env` [file](https://docs.docker.com/compose/compose-file/#env_file) or you can put sensitive information directly in the `docker-compose.yml` (not recommended).

```yml
version: "3.8"

services:
  gotify-nextcloud:
    image: gotify-nextcloud:latest
    container_name: gotify-nextcloud
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    environment:
      - NEXTCLOUD_URL=https://nextcloudexample.com
      - NEXTCLOUD_USER=$NEXTCLOUD_USER
      - NEXTCLOUD_PASSWORD=$NEXTCLOUD_PASSWORD
      - GOTIFY_URL=https://gotifyexample.com
      - GOTIFY_TOKEN=$GOTIFY_TOKEN
      - NOTIFICATION_DELAY=30
      - NOTIFICATION_PRIORITY=10
      - LOG_PATH=logs/gotify-nc.log
```

## Tips

- You can setup logging, by providing the path to a logfile in settings.py
- To use the provided servicefile, copy it to /etc/systemd/system and enable/start it. (To use it, push_msg.py must be located in /usr/local/bin/

## TODO

- [ ] Find a better way for authentication, as username and password are stored in plaintext in the settings.py file
- [ ] Use a persistent storage so that old notifications aren't resent, when the script is restarted
