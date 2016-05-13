extern crate iron;

use std::io::Read;
use std::fs::File;

use iron::prelude::*;
use iron::status;
use iron::mime::Mime;
use iron::method::Method::Post;

fn main() -> () {
    fn main_page(req: &mut Request) -> IronResult<Response> {
        let content_type = "text/html".parse::<Mime>().unwrap();
        let mut html = String::new();

        match req.method {
            Post => {
                let mut body = String::new();
                req.body.read_to_string(&mut body).unwrap();
                html = format!("<html><body>Thank you! You sent <b>{:?}</b><br/>The body was: {}</body></html>", req, body);
                Ok(Response::with((content_type, status::Ok, &html[..])))
            },
            _ => {

                let mut f: File = match File::open("index.html") {
                    Ok(f) => f,
                    Err(e) => panic!("{}", e),
                };

                f.read_to_string(&mut html).unwrap();

                Ok(Response::with((content_type, status::Ok, &html[..])))
            }
        }
    }

    Iron::new(main_page).http("localhost:3000").unwrap();
}
