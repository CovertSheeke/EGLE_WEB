# EGLE_WEB

---

## Overview

This Repo is a great test of mental and physical strength which I have failed repeatedly except for that one time when I was 10 that I hosted my own website which was just a clean rip-off of the charts.

---

## Deployment

In what may be a golden age for easy deployment, can I deploy a website using a git repo and a Hetnzer server (or AWS if I can't get it going on Hetzner)

---

## Local Testing

To test a locally dockerised version of the site use this command:

```sh
docker run --rm -it \
    -p 8080:80 \
    -v "$(pwd)/site":/usr/share/nginx/html:ro \
    nginx:alpine
```

and you should see a site on [http://localhost:8080](http://localhost:8080)