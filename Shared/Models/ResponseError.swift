// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let responseError = try ResponseError(json)

import Foundation

// MARK: - ResponseError
struct ResponseError: Codable {
    let errors: [APIError]?
}

// MARK: ResponseError convenience initializers and mutators

extension ResponseError {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ResponseError.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        errors: [APIError]?? = nil
    ) -> ResponseError {
        return ResponseError(
            errors: errors ?? self.errors
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Error
struct APIError: Codable {
    let message: String?
}

// MARK: Error convenience initializers and mutators

extension APIError {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(APIError.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        message: String?? = nil
    ) -> APIError {
        return APIError(
            message: message ?? self.message
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
