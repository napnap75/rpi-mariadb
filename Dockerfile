FROM napnap75/rpi-alpine-base:latest

# Install package and tune it
RUN apk add pwgen mariadb mariadb-client \
# comment out any "user" entires in the MySQL config ("docker-entrypoint.sh" or "--user" will handle user switching)
  && ls -al /etc/mysql/ \
  && sed -ri 's/^user\s/#&/' /etc/mysql/my.cnf \
# don't reverse lookup hostnames, they are usually another container
  && sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf \
  && echo 'skip-host-cache\nskip-name-resolve' | awk '{ print } $1 == "[mysqld]" && c == 0 { c = 1; system("cat") }' /etc/mysql/my.cnf > /tmp/my.cnf \
  && mv /tmp/my.cnf /etc/mysql/my.cnf

VOLUME /var/lib/mysql
EXPOSE 3306
CMD ["mysqld"]
