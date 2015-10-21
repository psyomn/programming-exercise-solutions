extern crate hyper;
extern crate regex;

use std::env;
use std::io::Read;

use regex::Regex;
use hyper::Client;
use hyper::client::Response;
use hyper::header::Connection;

fn main() -> () {
    let args: Vec<String> = env::args().collect();
    let sentence: String = match args.iter().nth(2) {
        Some(v) => v.clone(),
        None => {
            println!("Usage:\n  wsearch <http> <sentence>");
            return;
        },
    };

    let url: String = args.iter().nth(1).unwrap().clone();
    let url_ref: &str = url.as_ref();
    let re_url: String = format!("(?i){}", url);

    let re: Regex = Regex::new(sentence.as_ref()).unwrap();

    let mut http_client: Client = Client::new();

    let mut res: Response  = http_client.get(url_ref)
        .header(Connection::close())
        .send().unwrap();

    let mut body = String::new();
    res.read_to_string(&mut body).unwrap();

    if re.is_match(body.as_ref()) {
        println!("Found the sentence!");
    }
    else {
        println!("No such sentence at {}!", url);
    }
}

