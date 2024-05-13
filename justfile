#!/usr/bin/env just --justfile
#https://github.com/casey/just
set dotenv-load
set dotenv-filename := ".env.local"


@default:
  just --list


@struct:
  cargo modules structure -p proxy-rs --manifest-path ./ --focus-on proxy_rs::proxy::* --max-depth 11


@dep:
  cargo modules dependencies -p proxy-rs   --manifest-path ./ --focus-on proxy_rs::proxy::* --no-externs --no-sysroot|save -f docs/proxy-rs.proxy.a.dot

@dep2:
  cargo modules dependencies -p proxy-rs --manifest-path ./ --no-externs --no-sysroot --no-uses --max-depth 1|save -f docs/proxy-rs.proxy.b.dot

@dot:
  dot -Tpng ./docs/proxy-rs.proxy.b.dot -o ./docs/proxy-rs.proxy.b.png
  start ./docs/proxy-rs.proxy.b.png
