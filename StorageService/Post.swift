public struct Post {
    public let title: String
    public let author: String
    public let description: String
    public let image: String
    public let likes: Int
    public let views: Int
    
    public init(title: String, author: String, description: String, image: String, likes: Int, views: Int) {
        self.title = title
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
}
