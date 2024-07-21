FROM nginx:latest
MAINTAINER Ashkan Farivarmoheb

ENV DEST_FILE_NAME odoo_erp
ARG DOMAIN
# Copy SSL certificate and key to the container
COPY ssl/${DOMAIN}.crt /etc/nginx/ssl/${DEST_FILE_NAME}.crt
COPY ssl/${DOMAIN}.key /etc/nginx/ssl/${DEST_FILE_NAME}.key

# Copy modified nginx.conf file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose 443 port for HTTPS traffic
EXPOSE 443
