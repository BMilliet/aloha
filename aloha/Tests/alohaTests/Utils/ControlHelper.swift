import Foundation

@testable import aloha

enum ControlHelper {
    static func getControl1() -> TemplateControl {
        let data = ControlMock.json_regular.data(using: .utf8)
        return JsonHelper.decode(type: TemplateControl.self, data)!
    }
}
