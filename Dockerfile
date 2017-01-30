FROM centos:7

#ARG http_proxy=http://wwwproxy.hud.ac.uk:3128
#ARG https_proxy=http://wwwproxy.hud.ac.uk:3128

RUN yum -y install epel-release
RUN yum -y install nginx git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
