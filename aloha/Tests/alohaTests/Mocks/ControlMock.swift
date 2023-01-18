import Foundation

enum ControlMock {
    static let json1 = """
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
                                }
                            ]
                        }
                        """
}
