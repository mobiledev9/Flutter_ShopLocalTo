class Marketplace {
  Marketplace({
     this.id,
     this.name,
     this.description,
     this.price,
     this.link,
     this.image,
     this.type,
     this.category,
  });

  int id;
  String name;
  String description;
  int price;
  String link;
  String image;
  String type;
  String category;

  factory Marketplace.fromJson(Map<String, dynamic> json) => Marketplace(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    link: json["link"],
    image: json["image"],
    type: json["type"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "link": link,
    "image": image,
    "type": type,
    "category": category,
  };
  static List<Marketplace> listFromJson(List<dynamic> json) {
    return json == null
        ? List<Marketplace>()
        : json.map((value) => Marketplace.fromJson(value)).toList();
  }
}