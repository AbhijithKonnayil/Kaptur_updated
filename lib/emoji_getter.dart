import 'dart:math';
import 'package:flutter/services.dart';
import 'dart:convert';

class GetEmojis {
  static Future<List<String>> loadRandomStrings() async {
    final lines = await readFileLines();
    final randomStrings = getRandomStrings(lines, 12);
    return randomStrings;
    // Use the randomStrings list as desired
  }

  static List<String> getRandomStrings(List<String> lines, int count) {
    final random = Random();
    final sample = <String>[];
    while (sample.length < count) {
      final randomIndex = random.nextInt(lines.length);
      final randomString = lines[randomIndex];
      sample.add(randomString);
    }
    for (String i in sample) {
      print(i);
    }
    return sample;
  }

  static Future<List<String>> readFileLines() async {
    try {
      final fileContent = await rootBundle.loadString('lib/emojiList.txt'); // Replace 'file.txt' with your actual file name and path
      final lines = LineSplitter().convert(fileContent);
      return lines;
    } catch (e) {
      print('Error reading file: $e');
      return [];
    }
  }
}
