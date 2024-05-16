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

@judge:
  cargo modules dependencies -p proxy-rs   --manifest-path ./ --focus-on proxy_rs::judge::* --no-externs --no-sysroot --no-uses|save -f docs/judge/judge.a.dot

@dep:
  cargo modules dependencies -p proxy-rs   --manifest-path ./ --focus-on proxy_rs::proxy::* --no-externs --no-sysroot|save -f docs/proxy-rs.proxy.a.dot

@dep2:
  cargo modules dependencies -p proxy-rs --manifest-path ./ --no-externs --no-sysroot --no-uses --max-depth 1|save -f docs/proxy-rs.proxy.b.dot

@argument:
  cargo modules dependencies -p proxy-rs --manifest-path ./ --no-externs --no-sysroot --no-uses --max-depth 1 --focus-on  proxy_rs::argument::* | save -f docs/cli/argument.a.dot

@prodot:
  dot -Tpng ./docs/providers/providers.a.dot -o ./docs/providers/providers.a.png
  start ./docs/providers/providers.a.png

@clidot:
  dot -Tpng ./docs/cli/serveargs.a.dot -o ./docs/cli/serveargs.a.png
  start ./docs/cli/serveargs.a.png

@dot:
  dot -Tpng ./docs/deps/parking_lot.a.dot -o ./docs/deps/parking_lot.a.png
  start ./docs/deps/parking_lot.a.png

@test_checker:
  cargo test -- --nocapture test_checker_ip_re