struct TemplateControl: Decodable {
    let currentDir: String
    let targets: [ItemControl]
}

struct ItemControl: Decodable {
    let model: String
    let destination: String
}
