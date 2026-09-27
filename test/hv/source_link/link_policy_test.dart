import 'package:anymex/hv/source_link/core/link_policy.dart';
import 'package:flutter_test/flutter_test.dart';

bool replace({
  bool existingConfirmed = false,
  bool existingTrusted = true,
  bool newConfirmed = false,
  bool newTrusted = true,
}) =>
    hvShouldReplaceLink(
      existingConfirmed: existingConfirmed,
      existingTrusted: existingTrusted || existingConfirmed,
      newConfirmed: newConfirmed,
      newTrusted: newTrusted || newConfirmed,
    );

void main() {
  test("the user's pick always replaces the link", () {
    expect(replace(existingConfirmed: true, newConfirmed: true), isTrue);
    expect(replace(newConfirmed: true, newTrusted: false), isTrue);
  });

  test("an automatic match never replaces the user's pick", () {
    expect(replace(existingConfirmed: true), isFalse);
    expect(replace(existingConfirmed: true, newTrusted: false), isFalse);
  });

  test('a weak automatic match does not displace a good link', () {
    expect(replace(newTrusted: false), isFalse);
  });

  test('a good automatic match moves the link (user switched source)', () {
    expect(replace(), isTrue);
  });

  test('anything replaces a weak link', () {
    expect(replace(existingTrusted: false, newTrusted: false), isTrue);
  });
}
