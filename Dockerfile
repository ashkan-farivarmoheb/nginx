FROM nginx:latest

ENV NONPROD_DEST_FILE_NAME odoo_erp_nonprod
ENV PROD_DEST_FILE_NAME odoo_erp_prod
ENV ENVIRONMENT nonprod

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Copy Nonprod SSL certificate and key to the container
COPY downloads/nonprod/*.crt /etc/nginx/ssl/${NONPROD_DEST_FILE_NAME}.crt
COPY downloads/nonprod/*.key /etc/nginx/ssl/${NONPROD_DEST_FILE_NAME}.key

# Copy Prod SSL certificate and key to the container
COPY downloads/prod/*.crt /etc/nginx/ssl/${PROD_DEST_FILE_NAME}.crt
COPY downloads/prod/*.key /etc/nginx/ssl/${PROD_DEST_FILE_NAME}.key

# Copy Nginx configuration files
COPY nginx_nonprod.conf /etc/nginx/nonprod.conf
COPY nginx_prod.conf /etc/nginx/prod.conf

# Expose 443 port for HTTPS traffic
EXPOSE 443

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]