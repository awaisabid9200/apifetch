class Article {
  final String id;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String author;
  final String publishedAt;
  bool isLiked;
  bool isSave;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.author,
    required this.publishedAt,
    this.isLiked=false,
    this.isSave=false,

  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
      url: json['url'].toString(),
      imageUrl: json['urlToImage'].toString(),
      author:json['author'].toString(),
      publishedAt:json['publishedAt'].toString(),
    );
  }
}

