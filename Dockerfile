# Pin the base image so this project uses a reproducible NGINX version.
FROM ghcr.io/nginx/nginx-unprivileged:stable-alpine@sha256:15c994d10d6d78658721c3bcafff14cb281fba2a4bdf9d5ba92c416a472516e3

COPY nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080
