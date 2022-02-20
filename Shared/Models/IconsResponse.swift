// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let iconsResponse = try IconsResponse(json)

//
// To read values from URLs:
//
//   let task = URLSession.shared.iconsResponseTask(with: url) { iconsResponse, response, error in
//     if let iconsResponse = iconsResponse {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - IconsResponse
struct IconsResponse: Codable {
    let meta: Meta?
    let data: [Datum]
}

// MARK: IconsResponse convenience initializers and mutators

extension IconsResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IconsResponse.self, from: data)
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
        meta: Meta?? = nil,
        data: [Datum]
    ) -> IconsResponse {
        return IconsResponse(
            meta: meta ?? self.meta,
            data: data
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.datumTask(with: url) { datum, response, error in
//     if let datum = datum {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Datum
struct Datum: Codable, Hashable, Identifiable {
    static func == (lhs: Datum, rhs: Datum) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int?
    let title, code: String?
    let type: TypeEnum?
    let category: JSONNull?
    let url: String?
    let thumb: Thumb?
}

// MARK: Datum convenience initializers and mutators

extension Datum {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Datum.self, from: data)
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
        id: Int?? = nil,
        title: String?? = nil,
        code: String?? = nil,
        type: TypeEnum?? = nil,
        category: JSONNull?? = nil,
        url: String?? = nil,
        thumb: Thumb?? = nil
    ) -> Datum {
        return Datum(
            id: id ?? self.id,
            title: title ?? self.title,
            code: code ?? self.code,
            type: type ?? self.type,
            category: category ?? self.category,
            url: url ?? self.url,
            thumb: thumb ?? self.thumb
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.thumbTask(with: url) { thumb, response, error in
//     if let thumb = thumb {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Thumb
struct Thumb: Codable {
    let original: String?
    let small, large, xlarge: String?
}

// MARK: Thumb convenience initializers and mutators

extension Thumb {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Thumb.self, from: data)
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
        original: String?? = nil,
        small: String?? = nil,
        large: String?? = nil,
        xlarge: String?? = nil
    ) -> Thumb {
        return Thumb(
            original: original ?? self.original,
            small: small ?? self.small,
            large: large ?? self.large,
            xlarge: xlarge ?? self.xlarge
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case picture = "picture"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.metaTask(with: url) { meta, response, error in
//     if let meta = meta {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Meta
struct Meta: Codable {
    let totalIconCount, page, pageSize, pageCount: Int?

    enum CodingKeys: String, CodingKey {
        case totalIconCount = "total_icon_count"
        case page
        case pageSize = "page_size"
        case pageCount = "page_count"
    }
}

// MARK: Meta convenience initializers and mutators

extension Meta {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Meta.self, from: data)
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
        totalIconCount: Int?? = nil,
        page: Int?? = nil,
        pageSize: Int?? = nil,
        pageCount: Int?? = nil
    ) -> Meta {
        return Meta(
            totalIconCount: totalIconCount ?? self.totalIconCount,
            page: page ?? self.page,
            pageSize: pageSize ?? self.pageSize,
            pageCount: pageCount ?? self.pageCount
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func iconsResponseTask(with url: URL, completionHandler: @escaping (IconsResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

