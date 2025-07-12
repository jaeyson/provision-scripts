use actix_web::App;
use actix_web::HttpServer;
use actix_web::Responder;
use actix_web::get;
use openssl::ssl::SslAcceptor;
use openssl::ssl::SslFiletype;
use openssl::ssl::SslMethod;

#[get("/")]
async fn hello() -> impl Responder {
    "Hello, HTTPS!"
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let mut builder = SslAcceptor::mozilla_intermediate(SslMethod::tls()).unwrap();
    builder
        .set_private_key_file(
            "/etc/letsencrypt/live/test.nappy.co/privkey.pem",
            SslFiletype::PEM,
        )
        .unwrap();
    builder
        .set_certificate_chain_file("/etc/letsencrypt/live/test.nappy.co/fullchain.pem")
        .unwrap();
    HttpServer::new(|| App::new().service(hello))
        .bind_openssl("0.0.0.0:443", builder)?
        .run()
        .await
}
