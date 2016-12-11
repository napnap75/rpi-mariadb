# rpi-mariadb

# Post-installation
After installation, if you use a new Database, run the following commands inside the container (`docker run -it $CONTAINER-NAME bash`) :
```
# First allow remote access to the root user
mysql -e "CREATE USER 'root'@'%' ; GRANT ALL ON *.* TO 'root'@'%' ;" mysql
# Then, secure the installation (answer no when asked to remove remote access to root)
mysql_secure_installation
```
