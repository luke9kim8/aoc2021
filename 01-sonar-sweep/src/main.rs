use std::fs::File;
use std::io::{self, BufReader, BufRead};
use std::io::Lines;

fn main() {
    soln1();
    soln2();
}

fn read_lines(path: String) -> Lines<BufReader<File>> {
  BufReader::new(File::open(path).unwrap()).lines()
}

fn soln1() {
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

fn soln2() {
  let depths: Vec<u32> = read_lines(String::from("./input.txt")).map(|x| x.unwrap().parse::<u32>().unwrap()).collect();
  let mut prev_sum = depths[0] + depths[1] + depths[2];
  let mut count: u32 = 0;
  for (i, curr_depth) in depths.iter().map(|x| x.clone()).enumerate() {
    if i < 3 {
      continue;
    } else {
      let new_sum = prev_sum - depths[i - 3] + curr_depth;
      if new_sum > prev_sum {
        count += 1;
      }
      prev_sum = new_sum;
    }
  }
  println!("soln: {}", count);
}