//
//  File.swift
//  
//
//  Created by Jacob Hearst on 12/10/21.
//

import Foundation

class NetworkService {
    private var token: BearerToken?
    private var creds: TCGPlayerDeveloperCreds

    init(creds: TCGPlayerDeveloperCreds) {
        self.creds = creds
    }

    func getBearerToken(completion: @escaping () -> Void) {
        var tokenRequest = URLRequest(url: URL(string: "https://api.tcgplayer.com/token")!)
        let credString = "grant_type=client_credentials&client_id=\(creds.publicKey)&client_secret=\(creds.privateKey)"
        tokenRequest.httpBody = credString.data(using: .utf8)
        tokenRequest.httpMethod = "POST"

        request(tokenRequest, as: BearerToken.self) { result in
            switch result {
            case .success(let token):
                self.token = token
            case .failure(let error):
                print(error)
            }

            completion()
        }
    }

    func request<T : Decodable>(_ urlRequest: URLRequest, as type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        var request = urlRequest
        request.addValue(creds.userAgentHeader, forHTTPHeaderField: "User-Agent")

        if let token = token {
            request.addValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: \(String(describing: error))")
                completion(.failure(error!))
                return
            }

            guard let content = data else {
                print("Data was nil")
                return
            }

            let httpStatus = (response as! HTTPURLResponse).statusCode
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                if (200..<300).contains(httpStatus) {
                    print("Received response")
                    print(String(data: content, encoding: .utf8) ?? "Couldn't represent response body as string")

                    let result = try decoder.decode(type, from: content)
                    completion(.success(result))
                } else {
                    print("Error: \(content.description))")
                    completion(.failure(TCGPlayerKitError.networkingError(content.description)))
                }
            } catch {
                print(error)
                completion(.failure(error))
            }
        }

        print("Making request to: '\(String(describing: urlRequest.url?.absoluteString))'")
        task.resume()
    }
}
