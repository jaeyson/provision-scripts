use actix_web::{App, HttpServer, Responder, get};

#[get("/")]
async fn hello() -> impl Responder {
    "Hello, HTTPS!"
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| App::new().service(hello))
        .bind_openssl(
            "0.0.0.0:443",
            openssl::ssl::SslAcceptor::mozilla_intermediate(openssl::ssl::SslMethod::tls())
                .unwrap()
                .set_private_key_file(
                    "/etc/letsencrypt/live/test.nappy.co/privkey.pem",
                    openssl::ssl::SslFileType::PEM,
                )
                .set_certificate_chain_file(
                    "/etc/letsencrypt/live/test.nappy.co/fullchain.pem",
                    openssl::ssl::SslFileType::PEM,
                ),
        )?
        .run()
        .await
}
