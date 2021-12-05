use std::fs::File;
use std::io::{BufReader, BufRead};
use std::io::Lines;

fn main() {
    soln1();
}

pub fn read_lines(path: String) -> Lines<BufReader<File>> {
  BufReader::new(File::open(path).unwrap()).lines()
}

pub fn soln1() {
  let buf_lines = read_lines("./input.txt".to_string());
  let mut prev_val = 0;
  let mut counter = 0;
  for line in buf_lines {
    let depth: i32 = line.unwrap().parse().unwrap();
    if prev_val == 0 {
      prev_val = depth;
    } else {
      if prev_val < depth {
        counter += 1;
      }
    }
    prev_val = depth;
  }
  println!("counter: {}", counter);
}