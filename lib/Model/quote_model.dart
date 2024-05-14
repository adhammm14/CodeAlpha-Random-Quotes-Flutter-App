class QuoteModel {
  int? id;
  String? author;
  String? authorImage;
  String? quote;


  QuoteModel({required this.id,
    required this.author,
    required this.authorImage,
    required this.quote});

  QuoteModel.fromJson(Map json) {
    id = json['id'];
    author = json['author'];
    authorImage = json['authorImage'];
    quote = json['quote'];

  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'authorImage': authorImage,
      'quote': quote,
    };
  }
}