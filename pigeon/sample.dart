import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/generated/sample.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/app/src/main/kotlin/com/example/sendable_sample_for_flutter_issue_140439/Sample.g.kt',
    kotlinOptions: KotlinOptions(),
    swiftOut: 'ios/Runner/generated/Sample.g.swift',
    swiftOptions: SwiftOptions(),
  ),
)
@HostApi()
abstract class SampleApi {
  @async
  Sample fetchSampleFromMainActor();

  @async
  Sample fetchSampleFromActor();
}

class Sample {
  Sample({
    required this.text,
    required this.id,
  });
  final String text;
  final int id;
}
