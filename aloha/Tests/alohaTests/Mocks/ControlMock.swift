import Foundation

enum ControlMock {
    static let json_regular = """
                        {
                            "targets": [
                                {
                                  "model": "__name__ExampleDir",
                                  "destination": "SomeProject"
                                },
                                {
                                  "model": "Package.swift",
                                  "destination": "SomeProject"
                                },
                                {
                                  "model": "__name__Coordinator.swift",
                                  "destination": "SomeProject"
                                },
                                {
                                  "model": "JustCopyDir1",
                                  "destination": "SomeProject"
                                }
                            ],
                            "justCopy": [
                                "JustCopyDir1",
                                "JustCopyDir2",
                                "JustCopyFile.swift"
                            ]
                        }
                        """

    static let json_without_destination = """
                        {
                            "targets": [
                                {
                                  "model": "__name__ExampleDir"
                                },
                                {
                                  "model": "Package.swift"
                                },
                            ],
                            "justCopy": [
                                "JustCopyDir1",
                                "JustCopyDir2",
                                "JustCopyFile.swift"
                            ]
                        }
                        """
}
