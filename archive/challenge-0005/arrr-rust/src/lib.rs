extern crate rand;

use std::fmt;
use rand::Rng;

pub struct Pirate {
    name: String,
    attack: u32,
    defense: u32,
    hitpoints: u32,
}

pub struct PirateArena {
    protagonist: Pirate,
    antagonist: Pirate,
}

impl Pirate {
    pub fn new() -> Pirate {
        Pirate {
            name: "potato".to_string(),
            attack: 1,
            defense: 1,
            hitpoints: 20,
        }
    }

    pub fn get_name(&self) -> String {
        self.name.clone()
    }

    pub fn set_name(&mut self, new_name: String) -> () {
        self.name = new_name;
    }

    pub fn attack(&self) -> u32 {
        self.attack
    }

    pub fn defense(&self) -> u32 {
        self.defense
    }

    pub fn rcv_damage(&mut self, d: u32) -> () {
        let mut rng = rand::thread_rng();
        let t_def = rng.gen::<u32>() % self.defense;
        let dmg = if d < t_def { d - t_def } else { 0 };
        let final_dmg = if d < 0 { 0 } else { d };
        self.hitpoints = if self.hitpoints < final_dmg {
            0
        }
        else {
            self.hitpoints - final_dmg
        };
    }
}

impl PirateArena {
    pub fn new(p: Pirate, a: Pirate) -> PirateArena {
        PirateArena {
            protagonist: p,
            antagonist: a,
        }
    }

    pub fn done(&self) -> bool {
        self.protagonist.hitpoints == 0 ||
        self.antagonist.hitpoints == 0
    }

    pub fn step(&mut self) -> () {
        let p_at:  u32 = self.protagonist.attack();
        let a_at:  u32 = self.antagonist.attack();
        self.antagonist.rcv_damage(p_at);
        self.protagonist.rcv_damage(a_at);
    }

    pub fn winner(&self) -> Option<&Pirate> {
        if !self.done() {
            return None;
        }

        if self.protagonist.hitpoints > 0 {
            return Some(&self.protagonist);
        }
        else {
            return Some(&self.antagonist);
        }
    }
}

pub struct PirateBuilder {
    name: String,
    attack: u32,
    defense: u32,
}

impl PirateBuilder {
    pub fn new() -> PirateBuilder {
        PirateBuilder {
            name: "potato".to_string(),
            attack: 1,
            defense: 1,
        }
    }

    pub fn name(&mut self, s: String) -> &mut PirateBuilder {
        self.name = s;
        self
    }

    pub fn attack(&mut self, a: u32) -> &mut PirateBuilder {
        self.attack = a;
        self
    }

    pub fn defense(&mut self, d: u32) -> &mut PirateBuilder {
        self.defense = d;
        self
    }

    pub fn finalize(&self) -> Pirate {
        Pirate {
            name: self.name.clone(),
            attack: self.attack,
            defense: self.defense,
            hitpoints: 20,
        }
    }
}

impl fmt::Display for Pirate {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "[{}] hp: {}", self.name, self.hitpoints)
    }
}

impl fmt::Display for PirateArena {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let p = format!("{}", self.protagonist);
        let a = format!("{}", self.antagonist);
        write!(f, "{}\n{}\n", p, a)
    }
}
