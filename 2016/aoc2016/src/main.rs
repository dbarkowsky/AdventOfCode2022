mod days;
mod utils;
use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    let day: i32 = args[1].parse().unwrap();
    match day {
        1 => {
            days::day_01::part_one();
            days::day_01::part_two();
        }
        2 => {
            days::day_02::part_one();
            days::day_02::part_two();
        }
        3 => {
            days::day_03::part_one();
            days::day_03::part_two();
        }
        4 => {
            days::day_04::part_one();
            days::day_04::part_two();
        }
        5 => {
          println!("{}", "Day 05 can take a minute. Be patient.");
          days::day_05::part_one();
          days::day_05::part_two();
        }
        6 => {
          days::day_06::part_one();
          days::day_06::part_two();
        }
        7 => {
          days::day_07::part_one();
          days::day_07::part_two();
        }
        i32::MIN..=0_i32 | 2_i32..=i32::MAX => todo!(),
    }
}
