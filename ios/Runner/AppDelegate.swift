import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      guard let controller: FlutterViewController = window?.rootViewController as? FlutterViewController else {
          return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      }

      GeneratedPluginRegistrant.register(with: self)
      
      let sampleApi = SampleApiImpl()
      SampleApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: sampleApi)
      
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

final class SampleApiImpl: SampleApi, Sendable {
    private let sampleFetcherForMainActor: SampleFetcherForMainActor = .init()
    
    func fetchSampleFromMainActor(completion: @escaping (Result<Sample, Error>) -> Void) {
        let sample = sampleFetcherForMainActor.fetchSample()
        completion(.success(sample))
    }
    
    func fetchSampleFromActor(completion: @escaping (Result<Sample, Error>) -> Void) {
        Task {
            let sampleFetcher = SampleFetcherForActor()
            let sample = await sampleFetcher.fetchSample()
            completion(.success(sample))
        }
    }
}

@MainActor
final class SampleFetcherForMainActor {
    func fetchSample() -> Sample {
        .init(text: "sample", id: 1)
    }
}

actor SampleFetcherForActor {
    func fetchSample() -> Sample {
        .init(text: "sample", id: 1)
    }
}

