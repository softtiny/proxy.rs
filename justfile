#!/usr/bin/env just --justfile
#https://github.com/casey/just
set dotenv-load
set dotenv-filename := ".env.local"


@default:
  just --list


@struct:
  cargo modules structure -p proxy-rs --manifest-path ./ --focus-on proxy_rs::proxy::* --max-depth 11

@checker:
  cargo modules dependencies -p proxy-rs   --manifest-path ./ --focus-on proxy_rs::checker::* --no-externs --no-sysroot|save -f docs/checker/checker.a.dot

@checker2:
  cargo modules dependencies -p proxy-rs   --manifest-path ./ --focus-on proxy_rs::checker::* --no-externs --no-sysroot --no-uses|save -f docs/checker/checker.b.dot

@dep:
  cargo modules dependencies -p proxy-rs   --manifest-path ./ --focus-on proxy_rs::proxy::* --no-externs --no-sysroot|save -f docs/proxy-rs.proxy.a.dot

@dep2:
  cargo modules dependencies -p proxy-rs --manifest-path ./ --no-externs --no-sysroot --no-uses --max-depth 1|save -f docs/proxy-rs.proxy.b.dot

@argument:
  cargo modules dependencies -p proxy-rs --manifest-path ./ --no-externs --no-sysroot --no-uses --max-depth 1 --focus-on  proxy_rs::argument::* | save -f docs/cli/argument.a.dot


@clidot:
  dot -Tpng ./docs/cli/serveargs.a.dot -o ./docs/cli/serveargs.a.png
  start ./docs/cli/serveargs.a.png

@dot:
  dot -Tpng ./docs/checker/checker.c.dot -o ./docs/checker/checker.c.png
  start ./docs/checker/checker.c.png
