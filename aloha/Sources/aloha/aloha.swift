@main
public struct aloha {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(aloha().text)
    }
}