class ApiData {
  final String title;
  final String imageUrl;
  bool isLiked;

  ApiData({
    required this.title,
    required this.imageUrl,
    this.isLiked = false,
  });
}