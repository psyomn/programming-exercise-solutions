use std::io;
use std::ascii::AsciiExt;

fn echo(tx: Sender<String>, rc: Receiver<String>) {
    let mut message: String;
    let mut running: bool = true;

    while running {
        message = rc.recv();
        println!("ECHOSRV: recv {}", message);

        tx.send(message.clone().as_slice().to_ascii_upper().to_string());

        if message == "graceful".to_string() {
            println!("Ending echo server");
            running = false;
            continue;
        }
    }
}

fn main() {
    let (send_to_client, receiver):
        (Sender<String>, Receiver<String>)
        = channel();

    let (send_to_task, receive_at_task):
        (Sender<String>, Receiver<String>)
        = channel();

    let mut cmd: String = "default".to_string();

    spawn(proc(){ echo(send_to_client, receive_at_task) });

    while cmd != "graceful".to_string() {
        let mut reader = io::stdin();
        let input = reader.read_line().ok().unwrap_or("nothing".to_string());
        let to_trim: &[char] = &[' ', '\r', '\n'];
        let trimmed_input = input.as_slice().trim_chars(to_trim);
        send_to_task.send(trimmed_input.to_string());
        println!("Client Rcv: {}", receiver.recv());
        cmd = trimmed_input.to_string();
    }

}
