class Products {
    List<Product> product;

    Products({
        required this.product,
    });

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        product: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(product.map((x) => x.toJson())),
    };
}

class Product {
    int id;
    String title;
    String description;
    double price;
    double rating;
    List<String> images;

    Product({
        required this.id,
        required this.title,
        required this.description,
        required this.price,
        required this.rating,
        required this.images,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        images: List<String>.from(json["images"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "rating": rating,
        "images": List<dynamic>.from(images.map((x) => x)),
    };
}