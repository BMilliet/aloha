@testable import aloha

enum Methods {
    case fileHelperHomePathCalled,
         fileHelperExistCalled(path: String),
         fileHelperListCalled(path: String),
         fileHelperCreateDirCalled(path: String, withIntermediateDirectories: Bool),
         fileHelperReadFileCalled(path: String),
         fileHelperIsDirCalled(path: String),
         fileHelperCurrentDirCalled,
         fileHelperCopy(from: String, to: String),
         fileHelperMove(from: String, to: String),
         fileHelperWrite(content: String, path: String),

         generateCreateTemplateCalled(name: String, templatesDir: String),

         templateTemplatesDirCalled,
         templateUserHaveTemplateDirCalled,
         templateIsValidTemplateNameCalled(_ name: String),
         templateGetTemplateCalled(_ name: String),
         templateListTemplatesCalled,
         templateCreateAlohaCalled
}

extension Methods: Equatable {
}
