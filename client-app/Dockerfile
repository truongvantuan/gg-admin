FROM nginx:1.27.2
ARG CLIENT=dist.tar.gz
ARG NGINX_DIR=/usr/share/nginx/
COPY ${CLIENT} ${NGINX_DIR}
RUN cd ${NGINX_DIR} && tar -zxvf dist.tar.gz && rm -rf html && mv dist html
