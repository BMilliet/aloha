struct TemplateControl: Decodable {
    let targets: [ItemControl]
}

struct ItemControl: Decodable {
    let model: String
    let destination: String
}
