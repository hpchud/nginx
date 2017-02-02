# nginx

This is the nginx web server. It runs in a similar fashion to our `dns` and `ldap` containers. It is designed primarly to serve static content that is obtained by cloning a git repo or mounted as a Docker volume over `/var/www/html`.

At this moment in time it offers no control over the nginx configuration.

# Running it

```
docker run -d -p 80:80 \
    -e CONFIG_REPO=bitbucket.org/hpchud/config-repo-name.git \
    -e CONFIG_USER=hpchud
    -e CONFIG_PASS=<api key> \
    hpchud/nginx
```

# Configuring

There are two options to provide the data for `/var/www/html`. You can either mount a Docker volume, or, provide a configuration repository through the environment. This repository is expected to have the following layout:

```
./www/
           <static web content>
```

On startup, this repository will be cloned using `CONFIG_USER` and `CONFIG_PASS` as the credentials. Whilst this image can be public, you don't want the configuration to be.

The files in `www` folder will be copied to `/usr/share/nginx/html`.