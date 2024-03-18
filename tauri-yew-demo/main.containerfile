FROM docker.io/library/rust:slim as base
WORKDIR /app
RUN ["rustup", "target", "add", "wasm32-unknown-unknown"]
RUN apt-get update && apt-get install -y curl
RUN curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
RUN ["cargo", "binstall", "-y", "--no-cleanup", "trunk", "wasm-bindgen-cli"]


FROM base as builder
COPY . ./
RUN ["trunk", "build", "--release"]
