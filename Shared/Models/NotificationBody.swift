// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let notificationBody = try NotificationBody(json)

import Foundation

// MARK: - NotificationBody
struct NotificationBody: Codable {
    let priority: String?
    let model: Model?
    
    static func create(message: String, using icon: Int, with soundID: APIConstants.SoundID) -> NotificationBody {
        return NotificationBody(priority: "warning", model: Model(cycles: 1, frames: [Frame(icon: icon, text: message)], sound: Sound(category: "notifications", id: soundID.rawValue)))
    }
}

// MARK: NotificationBody convenience initializers and mutators

extension NotificationBody {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NotificationBody.self, from: data)
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
        priority: String?? = nil,
        model: Model?? = nil
    ) -> NotificationBody {
        return NotificationBody(
            priority: priority ?? self.priority,
            model: model ?? self.model
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Model
struct Model: Codable {
    let cycles: Int?
    let frames: [Frame]?
    let sound: Sound?
}

// MARK: Model convenience initializers and mutators

extension Model {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Model.self, from: data)
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
        cycles: Int?? = nil,
        frames: [Frame]?? = nil,
        sound: Sound?? = nil
    ) -> Model {
        return Model(
            cycles: cycles ?? self.cycles,
            frames: frames ?? self.frames,
            sound: sound ?? self.sound
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Frame
struct Frame: Codable {
    let icon: Int?
    let text: String?
}

// MARK: Frame convenience initializers and mutators

extension Frame {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Frame.self, from: data)
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
        icon: Int?? = nil,
        text: String?? = nil
    ) -> Frame {
        return Frame(
            icon: icon ?? self.icon,
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Sound
struct Sound: Codable {
    let category, id: String?
}

// MARK: Sound convenience initializers and mutators

extension Sound {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Sound.self, from: data)
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
        category: String?? = nil,
        id: String?? = nil
    ) -> Sound {
        return Sound(
            category: category ?? self.category,
            id: id ?? self.id
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
