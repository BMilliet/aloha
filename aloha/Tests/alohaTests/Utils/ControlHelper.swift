import Foundation

@testable import aloha

enum ControlHelper {
    static func getControl1() -> TemplateControl {
        let data = ControlMock.json1.data(using: .utf8)
        return JsonHelper.decode(type: TemplateControl.self, data)!
    }
}
