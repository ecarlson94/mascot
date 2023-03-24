import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/microphone/device/web/web_microphone.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late WebMicrophone classUnderTest;

  setUp(() {
    context = TestContext();
    classUnderTest = WebMicrophone(
      context.mocks.audioContext,
      context.mocks.getLogger(),
    );
  });
}
