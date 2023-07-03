ARG DEBIAN_VERSION=12

# From latest(v941edb36a) tkn
FROM ileixe/tkn:v941edb36a as tkn

FROM rust:latest as rust
COPY . /src
WORKDIR /src
RUN cargo install --path .

FROM debian:${DEBIAN_VERSION}
COPY --from=tkn /usr/bin/tkn /usr/bin/
COPY --from=rust /src/target/release/tkn-watch /usr/local/bin/tkn-watch
