import Foundation

struct JsonHelper {
    static func decode<T: Decodable>(type: T.Type, _ data: Data?) -> T? {
        guard let data = data else { return nil }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}
