import 'dart:math';

class RandomStringGenerator {
  static const _lowercase = 'abcdefghijklmnopqrstuvwxyz';
  static const _uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const _numbers = '0123456789';

  final Random _random = Random();

  String generate(int length) {
    const characters = _lowercase + _uppercase + _numbers;
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(_random.nextInt(characters.length))));
  }
}
