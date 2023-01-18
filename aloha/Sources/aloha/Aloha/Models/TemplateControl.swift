struct TemplateControl: Decodable {
    var targets: [ItemControl]
}

struct ItemControl: Decodable {
    var model: String
    var destination: String
}
