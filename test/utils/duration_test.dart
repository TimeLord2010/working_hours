import 'package:flutter_test/flutter_test.dart';
import 'package:work_hours_tracking/utils/duration.dart';

void main() {
  test('duration ...', () async {
    const duration = Duration(
      days: 2,
      hours: 4,
      minutes: 54,
      seconds: 5,
    );
    expect(duration.toReadableString(), '02d 04h 54min 05s');
  });
}
