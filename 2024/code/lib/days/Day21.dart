import 'dart:collection';
import 'dart:core';
import 'package:code/days/Day.dart';

// My good friend, Coordinate, back again.
typedef Coordinate = ({int x, int y});

class SearchState {
  Coordinate location;
  List<Coordinate> visited = [];
  SearchState(this.location, this.visited);
}

class Day21 extends Day {
  Day21(super.fileName, super.useTestData);

  Map<String, Coordinate> numPad = {
    '7': (x: 0, y: 0),
    '8': (x: 0, y: 1),
    '9': (x: 0, y: 2),
    '4': (x: 1, y: 0),
    '5': (x: 1, y: 1),
    '6': (x: 1, y: 2),
    '1': (x: 2, y: 0),
    '2': (x: 2, y: 1),
    '3': (x: 2, y: 2),
    '0': (x: 3, y: 1),
    'A': (x: 3, y: 2),
  };

  Map<String, Coordinate> dirPad = {
    '^': (x: 0, y: 1),
    'A': (x: 0, y: 2),
    '<': (x: 1, y: 0),
    'v': (x: 1, y: 1),
    '>': (x: 1, y: 2),
  };
  Map<String, String> cache = {};
  void part1() {
    int total = 0;
    for (final code in input) {
      String start = 'A';
      String joinedDirections = "";
      for (int i = 0; i < code.length; i++) {
        String end = code[i];
        // Get initial inputs for possible keypad presses
        List<List<Coordinate>> paths = getShortestPaths(start, end, numPad);
        // Convert to direction strings
        List<List<String>> directions =
            paths.map(convertPathToInstructions).toList();
        // Use converter to get smallest amount of steps at x depth of robots
        String convertedDirections = layerRobots(2, directions);
        joinedDirections += convertedDirections;
        start = code[i];
      }
      // Get complexity score
      RegExp number = RegExp(r"[\d]+");
      int numericPart = int.parse(number.firstMatch(code)!.group(0)!);
      total += joinedDirections.length * numericPart;
    }
    print(total);
  }

  void part2() {
    int total = 0;
    int steps = 25;
    for (final code in input) {
      print(code);
      String start = 'A';
      String joinedDirections = "";
      for (int i = 0; i < code.length; i++) {
        String end = code[i];
        // TODO: if we've seen this start and end before, we should know the end result to return
        // Get initial inputs for possible keypad presses
        List<List<Coordinate>> paths = getShortestPaths(start, end, numPad);
        // Convert to direction strings
        List<List<String>> directions = paths
            .map(convertPathToInstructions)
            .where(hasNoInefficiencies)
            .toList();
        // print(directions);
        String convertedDirections = "";

        // Use converter to get smallest amount of steps at x depth of robots
        convertedDirections = layerRobots(steps, directions);

        joinedDirections += convertedDirections;
        start = code[i];
      }
      // Get complexity score
      RegExp number = RegExp(r"[\d]+");
      int numericPart = int.parse(number.firstMatch(code)!.group(0)!);
      total += joinedDirections.length * numericPart;
    }
    print(total);
  }

  bool hasNoInefficiencies(List<String> directions) {
    if (directions.length < 4) return true;
    if (directions[0] == directions[2] && directions[0] != directions[1])
      return false;
    return true;
  }

  String layerRobots(int remainingLayers, List<List<String>> directions) {
    if (directions.isEmpty) return "";
    if (remainingLayers == 0) {
      return directions.first.join("");
    }
    List<List<String>> newDirections = [];
    for (final possibleDirections in directions) {
      String dirKey = possibleDirections.join("");
      if (cache.containsKey(dirKey)) {
          newDirections.add(cache[dirKey]!.split("").toList());
      } else {
// print('possibleDirections: $possibleDirections');
      if (possibleDirections.isEmpty) continue;
      String start = 'A';
      String joinedDirections = "";
      for (int i = 0; i < possibleDirections.length; i++) {
        String end = possibleDirections[i];
        String key = '$start,$end,$remainingLayers';
        if (cache.containsKey(key)) {
          joinedDirections += cache[key]!;
        } else {
// Get initial inputs for possible keypad presses
          List<List<Coordinate>> paths = getShortestPaths(start, end, dirPad);
          // Convert to direction strings
          List<List<String>> directions = paths
              .map(convertPathToInstructions)
              .where(hasNoInefficiencies)
              .toList();
          // print('$start, $end, ${directions.join("")}');

          // Use converter to get smallest amount of steps at x depth of robots
          String convertedDirections =
              layerRobots(remainingLayers - 1, directions);
          cache[key] = convertedDirections;
          // List<String> dividedDirections =
          //     convertedDirections.split("A").map((e) => '${e}A').toList();
          // List<String> trimmedDirections =
          //     dividedDirections.sublist(0, dividedDirections.length - 1);
          // print('trimmedDrections ${trimmedDirections}');
          // print('convertedDirections: $convertedDirections');
          joinedDirections += convertedDirections;
        }

        start = possibleDirections[i];
      }
      newDirections.add(joinedDirections.split("").toList());
      }
    }
    // All sublists have been converted, find the shortest one.
    List<String> stringDirs = newDirections.map((e) => e.join("")).toList();
    stringDirs.sort((a, b) => a.length - b.length);
    return stringDirs.first;
  }

  String makeDirectionsKey(List<List<String>> dirList, int layers) {
    List<String> directions = dirList.map((e) => e.join("")).toList();
    directions.sort();
    return directions.join("") + layers.toString();
  }

  List<String> convertPathToInstructions(List<Coordinate> path) {
    List<String> instructions = [];
    for (int i = 1; i < path.length; i++) {
      Coordinate a = path[i - 1];
      Coordinate b = path[i];

      if (b.x > a.x) {
        // moving down
        instructions.add("v");
      } else if (a.x > b.x) {
        // moving up
        instructions.add("^");
      } else if (b.y > a.y) {
        // moving right
        instructions.add(">");
      } else if (a.y > b.y) {
        // moving left
        instructions.add("<");
      }
    }
    instructions.add('A');
    return instructions;
  }

  // TODO: Cache this too
  List<List<Coordinate>> getShortestPaths(
      String from, String to, Map<String, Coordinate> pad) {
    List<List<Coordinate>> paths = [];
    Coordinate start = pad[from]!;
    Coordinate end = pad[to]!;
    Queue<SearchState> queue = Queue();
    queue.add(SearchState(start, [start]));
    while (queue.isNotEmpty) {
      SearchState current = queue.removeFirst();
      if (current.location == end) {
        paths.add(current.visited);
        continue;
      }

      List<Coordinate> neighbours =
          getNextNeighbours(current.location, 3, current.visited)
              .where((n) => pad.containsValue(n))
              .toList();
      queue.addAll(
          neighbours.map((n) => SearchState(n, [...current.visited, n])));
    }
    int min = paths.first.length;
    for (final path in paths) {
      if (path.length < min) {
        min = path.length;
      }
    }
    return paths.where((p) => p.length == min).toList();
  }

  List<Coordinate> getNextNeighbours(
      Coordinate start, int max, List<Coordinate> exclude,
      {int withinDistance = 1}) {
    List<Coordinate> offsets = [];
    for (int x = -withinDistance; x <= withinDistance; x++) {
      for (int y = -withinDistance; y <= withinDistance; y++) {
        if (x.abs() + y.abs() <= withinDistance) offsets.add((x: x, y: y));
      }
    }
    return offsets
        .map((offset) => (x: start.x + offset.x, y: start.y + offset.y))
        .where((coord) =>
            coord.x >= 0 && coord.y >= 0 && coord.x <= max && coord.y <= max)
        .where((coord) => !exclude.contains(coord))
        .toList();
  }
}
