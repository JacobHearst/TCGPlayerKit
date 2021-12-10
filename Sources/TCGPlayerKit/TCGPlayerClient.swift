import Foundation

public struct TCGPlayerClient {
    private let networkService: NetworkService

    public init(creds: TCGPlayerDeveloperCreds) {
        self.networkService = NetworkService(creds: creds)
        let sem = DispatchSemaphore(value: 0)
        networkService.getBearerToken { sem.signal() }
        sem.wait()
    }

    public func getPricing(for ids: [Int], completion: @escaping (Result<ProductMarketPriceResponse, Error>) -> Void) {
        guard !ids.isEmpty else {
            completion(.failure(TCGPlayerKitError.emptyIds))
            return
        }

        let idList = ids.map { "\($0)" }.joined(separator: ",")
        guard let url = URL(string: "https://api.tcgplayer.com/pricing/product/\(idList)") else {
            print("Invalid url from idList: \(idList)")
            return
        }

        let request = URLRequest(url: url)
        networkService.request(request, as: ProductMarketPriceResponse.self, completion: completion)
    }
}
