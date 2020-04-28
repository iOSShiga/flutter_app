




class Product {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Product(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      json['albumId'],
      json['id'],
      json['title'],
      json['url'],
      json['thumbnailUrl']
    );
    }
}
