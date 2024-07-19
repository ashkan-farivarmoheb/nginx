FROM nginx:latest
MAINTAINER Ashkan Farivarmoheb

# Copy SSL certificate and key to the container
COPY ssl/erp.tisol.com.au.crt /etc/nginx/ssl/erp.tisol.com.au.crt
COPY ssl/erp.tisol.com.au.key /etc/nginx/ssl/erp.tisol.com.au.key

# Copy modified nginx.conf file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose 443 port for HTTPS traffic
EXPOSE 443
