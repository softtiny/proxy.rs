use std::collections::BTreeMap;
use tokio::{
    sync::mpsc,
    runtime,
    time::{
        sleep,Duration,
    },
};
use proxy_rs::proxy::Proxy;
use proxy_rs::resolver::GeoData;
use proxy_rs::server::{proxy_pool::LIVE_PROXIES, Server};


#[tokio::test]
async fn proxy_xcxcxxcxcx_simple() {
    println!("test pass");
}

#[test]
fn proxy_simple() {

    runtime::Builder::new_multi_thread()
        .worker_threads(4)
        .enable_all()
        .build()
        .unwrap()
        .block_on(async move {
            println!("....................");
            println!("wait 3s start");
            sleep(Duration::from_secs(3)).await;
            println!("wait 3s end");
            let mut host = "0.0.0.0".to_string();
            let mut port = 8080;
            println!("....................1");
            let (tx , mut rx) = mpsc::channel(50);
            println!("....................2");
            tokio::task::spawn(async move {
                println!("wait 3s start");
                sleep(Duration::from_secs(3)).await;
                println!("wait 3s end");
                let mut geodata = GeoData::default();
                let proxy = Proxy{
                    host:"192.168.1.190".to_string(),
                    port: 1080,
                    expected_types:vec!["HTTP".to_string()],
                    geo:geodata,
                    types: vec![],
                    schemes: vec![],
                    logs: vec![],
                    negotiator_proto: "HTTP".to_string(),
                    timeout: 5,
                    runtimes: vec![],
                    tcp_stream: None,
                    tls_stream: None,
                    verify_ssl: false,
                    request_stat: 0,
                    error_stat: BTreeMap::new(),
                    is_working: false,
                };
                tx.send(Some(proxy)).await.unwrap();
                println!("wait 3s end.2");
            });
            tokio::task::spawn(async move {
                println!("sdfasfdas --");
                let server = Server::new(host.as_str(), port);
                println!("sdfasfdas --2");
                server.start().await;
                println!("sdfasfdas --3");
            });


            println!("....................3");
            loop {
                if let Some(Some(proxy)) = rx.recv().await {
                    println!("{:?}",proxy);
                    LIVE_PROXIES.push(proxy).unwrap();
                }
            }
        });
}