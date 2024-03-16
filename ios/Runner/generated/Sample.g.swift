// Autogenerated from Pigeon (v17.1.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// Generated class from Pigeon that represents data sent in messages.
struct Sample: Sendable {
  var text: String
  var id: Int64

  static func fromList(_ list: [Any?]) -> Sample? {
    let text = list[0] as! String
    let id = list[1] is Int64 ? list[1] as! Int64 : Int64(list[1] as! Int32)

    return Sample(
      text: text,
      id: id
    )
  }
  func toList() -> [Any?] {
    return [
      text,
      id,
    ]
  }
}

private class SampleApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 128:
      return Sample.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class SampleApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? Sample {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class SampleApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return SampleApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return SampleApiCodecWriter(data: data)
  }
}

class SampleApiCodec: FlutterStandardMessageCodec {
  static let shared = SampleApiCodec(readerWriter: SampleApiCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol SampleApi {
  func fetchSampleFromMainActor(completion: @Sendable @escaping (Result<Sample, Error>) -> Void)
  func fetchSampleFromActor(completion: @Sendable @escaping (Result<Sample, Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class SampleApiSetup {
  /// The codec used by SampleApi.
  static var codec: FlutterStandardMessageCodec { SampleApiCodec.shared }
  /// Sets up an instance of `SampleApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: SampleApi?) {
    let fetchSampleFromMainActorChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.sendable_sample_for_flutter_issue_140439.SampleApi.fetchSampleFromMainActor", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      fetchSampleFromMainActorChannel.setMessageHandler { _, reply in
        api.fetchSampleFromMainActor { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      fetchSampleFromMainActorChannel.setMessageHandler(nil)
    }
    let fetchSampleFromActorChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.sendable_sample_for_flutter_issue_140439.SampleApi.fetchSampleFromActor", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      fetchSampleFromActorChannel.setMessageHandler { _, reply in
        api.fetchSampleFromActor { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      fetchSampleFromActorChannel.setMessageHandler(nil)
    }
  }
}
