enum TemplateModelFactory {
    static func build(_ control: TemplateControl,
                      originAbs: String,
                      destAbs: String) -> TemplateModel {

        TemplateModel(
            targets: makeItems(
                control.targets,
                originAbs: originAbs,
                destAbs: destAbs
            )
        )
    }

    private static func makeItems(_ items: [ItemControl],
                                  originAbs: String,
                                  destAbs: String) -> [ItemModel] {
        return items.map {
            ItemModel(model: "\(originAbs)/\($0.model)",
                      destination: "\(destAbs)/\($0.destination)")
        }
    }
}

struct TemplateModel {
    let targets: [ItemModel]
}

struct ItemModel {
    let model: String
    let destination: String
}
