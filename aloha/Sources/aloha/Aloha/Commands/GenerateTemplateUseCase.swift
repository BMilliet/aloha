import Foundation

struct GenerateTemplateUseCase {
    let fileManager: FileHelper
    let template: String

    func start() {
        print(fileManager.homePath())
    }
}
