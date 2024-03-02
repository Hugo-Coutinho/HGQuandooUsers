//
//  File.swift
//
//
//  Created by Hugo Coutinho on 2024-03-02.
//

import Users
import HGNetworkLayer
import Foundation

public class BaseRequestSuccessHandlerSpy {
    // MARK: - ENUM -
    public enum ServiceEnum {
        case users
    }
    
    // MARK: - DECLARATIONS -
    public var service: ServiceEnum
    
    public init(service: ServiceEnum) {
        self.service = service
    }
}

// MARK: - BaseAsyncRequestInput -
extension BaseRequestSuccessHandlerSpy: BaseAsyncRequestInput {
    public func asyncWith(_ url: URL) async throws -> Data {
        if let data = readLocalFile(forName: getLocalFileNameByService()) {
            return data
        } else {
            fatalError("should return json data")
        }
    }
}

// MARK: - ASSISTANT -
extension BaseRequestSuccessHandlerSpy {
    private func getLocalFileNameByService() -> String {
        switch self.service {
        case .users:
            return "Users_data"
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}

// MARK: - BaseAsyncRequestInput -
public class BaseRequestErrorHandlerSpy: BaseAsyncRequestInput {
    public init() {}
    
    public func asyncWith(_ url: URL) async throws -> Data {
        throw APIError(type: .unknown)
    }
}

