# Stage 1: Build the Hugo site
FROM klakegg/hugo:ext-ubuntu as builder

WORKDIR /src
COPY . .

# Build the static site
RUN hugo --minify

# Stage 2: Serve the site with Nginx
FROM nginx:alpine

# Copy the compiled site from builder
COPY --from=builder /src/public /usr/share/nginx/html

# Copy custom Nginx configuration if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]