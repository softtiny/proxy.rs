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

@libdot:
  dot -Tpng ./docs/server/server.a.dot -o ./docs/server/server.a.png
  start ./docs/server/server.a.png

@clidot:
  dot -Tpng ./docs/cli/cli_parse.a.dot -o ./docs/cli/cli_parse.a.png
  start ./docs/cli/cli_parse.a.png

@bakdot:
  dot -Tpng ./docs/deps/parking_lot.a.dot -o ./docs/deps/parking_lot.a.png
  start ./docs/deps/parking_lot.a.png

@dot:
  dot -Tpng ./docs/main/main.a.dot -o ./docs/main/main.a.png
  start ./docs/main/main.a.png


@stddot:
  dot -Tpng ./docs/std/macro.a.dot -o ./docs/std/macro.a.png
  start ./docs/std/macro.a.png

@test_checker:
  cargo test -- --nocapture test_checker_ip_re