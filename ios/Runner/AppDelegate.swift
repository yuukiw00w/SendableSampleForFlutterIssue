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
    // error: Call to main actor-isolated initializer 'init()' in a synchronous nonisolated context
//    let sampleFetcherForMainActor: SampleFetcherForMainActor = .init()
    
    func fetchSampleFromMainActor(completion: @MainActor @Sendable @escaping (Result<Sample, Error>) -> Void) {
        Task { @MainActor in
            let sampleFetcher: SampleFetcherForMainActor = .init()
            let sample = sampleFetcher.fetchSample()
            completion(.success(sample))
        }
    }
    
    func fetchSampleFromActor(completion: @MainActor @Sendable @escaping (Result<Sample, Error>) -> Void) {
        Task.detached {
            let sampleFetcher = SampleFetcherForActor()
            let sample = await sampleFetcher.fetchSample()
            await completion(.success(sample))
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

