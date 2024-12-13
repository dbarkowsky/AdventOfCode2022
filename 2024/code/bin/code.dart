import 'package:code/days/Day01.dart';
import 'package:code/days/Day02.dart';
import 'package:code/days/Day03.dart';
import 'package:code/days/Day04.dart';
import 'package:code/days/Day05.dart';
import 'package:code/days/Day06.dart';
import 'package:code/days/Day07.dart';
import 'package:code/days/Day08.dart';
import 'package:code/days/Day09.dart';
import 'package:code/days/Day10.dart';
import 'package:code/days/Day11.dart';
import 'package:code/days/Day12.dart';
import 'package:code/days/Day13.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print(
        'No day was provided. Run "dart run code <day number>" to select a day.');
  }
  final day = int.parse(arguments.first);
  bool useTestData = arguments.length > 1 ? arguments[1] == 'test' : false;
  switch (day) {
    case 1:
      Day01 day01 = Day01('day01', useTestData);
      day01.part1();
      day01.part2();
      break;
    case 2:
      Day02 day02 = Day02('day02', useTestData);
      day02.part1();
      day02.part2();
      break;
    case 3:
      Day03 day03 = Day03('day03', useTestData);
      day03.part1();
      day03.part2();
      break;
    case 4:
      Day04 day04 = Day04('day04', useTestData);
      day04.part1();
      day04.part2();
      break;
    case 5:
      Day05 day05 = Day05('day05', useTestData);
      day05.part1();
      day05.part2();
      break;
    case 6:
      Day06 day06 = Day06('day06', useTestData);
      day06.part1();
      day06.part2();
      break;
    case 7:
      Day07 day07 = Day07('day07', useTestData);
      day07.part1();
      day07.part2();
      break;
    case 8:
      Day08 day08 = Day08('day08', useTestData);
      day08.part1();
      day08.part2();
      break;
    case 9:
      Day09 day09 = Day09('day09', useTestData);
      day09.part1();
      day09.part2();
      break;
    case 10:
      Day10 day10 = Day10('day10', useTestData);
      day10.part1();
      day10.part2();
      break;
    case 11:
      Day11 day11 = Day11('day11', useTestData);
      day11.part1();
      day11.part2();
      break;
    case 12:
      Day12 day12 = Day12('day12', useTestData);
      day12.part1();
      day12.part2();
      break;
    case 13:
      Day13 day13 = Day13('day13', useTestData);
      day13.part1();
      day13.part2();
      break;
    default:
  }
}
