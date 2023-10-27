struct TemplateControl: Decodable {
    var targets: [ItemControl]
    var justCopy: [String]?
}

struct ItemControl: Decodable {
    var model: String
    var destination: String?
}
