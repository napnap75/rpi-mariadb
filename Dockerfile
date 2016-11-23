FROM napnap75/rpi-alpine-base:latest

# Install package and tune it
RUN apk add pwgen mariadb mariadb-client \
# comment out any "user" entires in the MySQL config ("docker-entrypoint.sh" or "--user" will handle user switching)
  && sed -ri 's/^user\s/#&/' /etc/mysql/my.cnf \
# don't reverse lookup hostnames, they are usually another container
  && sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf \
  && echo "skip-host-cache" | awk '{ print } $1 == "[mysqld]" && c == 0 { c = 1; system("cat") }' /etc/mysql/my.cnf > /tmp/my.cnf \
  && echo "skip-name-resolve" | awk '{ print } $1 == "[mysqld]" && c == 0 { c = 1; system("cat") }' /etc/mysql/my.cnf > /tmp/my.cnf \
  && mv /tmp/my.cnf /etc/mysql/my.cnf

# Use the volume to store mysql data outside of the image
VOLUME /var/lib/mysql

# Expose mysql default port
EXPOSE 3306

# Add the specific run script to create the database if necessary
ADD start-mysql.sh /usr/bin/start-mysql.sh
RUN chmod +x /usr/bin/start-mysql.sh

# Default command to run
CMD ["/usr/bin/start-mysql.sh"]
