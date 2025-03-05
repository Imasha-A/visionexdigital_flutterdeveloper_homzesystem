class PropertyModel {
  final String id;
  final String title;
  final String imageUrl;
  final String location;
  final double price;
  final int beds;
  final int bathrooms;

  PropertyModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.location,
    required this.price,
    required this.beds,
    required this.bathrooms,
  });

  factory PropertyModel.fromFirestore(Map<String, dynamic> data, String docId) {
    return PropertyModel(
      id: docId,
      title: data['title'] ?? '',
      imageUrl: data['image'] ?? '',
      location: data['location'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      beds: data['number of beds'] ?? 0,
      bathrooms: data['number of bathrooms'] ?? 0,
    );
  }
}
