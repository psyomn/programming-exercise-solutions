use std::cmp::Ordering;

#[derive(Debug)]
struct Candidate {
    name: String,
    votes: usize,
}

impl Ord for Candidate {
    fn cmp(&self, other: &Self) -> Ordering {
        if self.votes == other.votes {
            Ordering::Equal
        }
        else if self.votes < other.votes {
            Ordering::Less
        }
        else {
            Ordering::Greater
        }
    }
}

impl PartialOrd for Candidate {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl PartialEq for Candidate {
    fn eq(&self, other: &Self) -> bool {
        self.votes == other.votes
    }
}

impl Eq for Candidate { }

impl Candidate {
    fn new(n: String) -> Candidate {
        Candidate {
            name: n,
            votes: 0,
        }
    }

    fn process_votes(&mut self, votes: &[String]) -> () {
        for v in votes {
            if self.name == *v {
                self.votes += 1;
            }
        }
    }
}

fn main() -> () {
    let candidates: Vec<Candidate> = vec![
        Candidate::new("A".into()),
        Candidate::new("B".into()),
    ];

    let votes: Vec<String> = vec!["A".into(), "B".into(), "A".into()];

    let mut proc_cand = Vec::new();

    for mut can in candidates {
        can.process_votes(&votes);
        proc_cand.push(can);
    }

    proc_cand.sort();

    if inconclusive(&proc_cand) {
        panic!("no one wins");
    }

    println!("Winner is: {:?}", proc_cand.pop().unwrap());
}

fn inconclusive(cs: &[Candidate]) -> bool {
    let l = cs.len();

    if l == 0 {
        true
    }
    else if l == 1 {
        false
    }
    else {
        cs[0].votes == cs[1].votes
    }
}
