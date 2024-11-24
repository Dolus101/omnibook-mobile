class Book {
  final String title;
  final String author;
  final String categories;
  final String publishDate;

  Book({
    required this.title,
    required this.author,
    required this.categories,
    required this.publishDate,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      categories: json['categories'],
      publishDate: json['publishDate'],
    );
  }
}
