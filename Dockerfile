FROM ubuntu:latest AS BUILD_IMAGE
RUN apt update && apt install wget unzip -y
RUN wget https://www.tooplate.com/zip-templates/2108_dashboard.zip
RUN unzip 2108_dashboard.zip && cd 2108_dashboard && tar -czf dashboard.tgz * && mv dashboard.tgz /root/dashboard.tgz

FROM ubuntu:latest
LABEL "project"="Dashboard"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install apache2 git wget -y
COPY --from=BUILD_IMAGE /root/dashboard.tgz /var/www/html/
RUN cd /var/www/html/ && tar xzf dashboard.tgz
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
VOLUME /var/log/apache2
WORKDIR /var/www/html/
EXPOSE 80
