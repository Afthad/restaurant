

class Products{
 final String name;
 final List <Cat1> products;
  bool isOpen;

  Products({
   required this.name,
   required this.isOpen,
  
   required this.products,
 
  });
  factory Products.fromJson(Map<dynamic, dynamic> json) => Products(
 
    isOpen: json['isOpen'],
        name: json["cat"],
        products: List<Cat1>.from(json["productList"]!.map((x) => Cat1.fromJson(x))),
        
      );

}
class Cat1 {
  Cat1({
    this.name,
    required this.count,
    this.price,
    this.instock,

  });

  String? name;
  int? price;
  bool? instock;
  int count;

  factory Cat1.fromJson(Map<dynamic, dynamic> json) => Cat1(
        name: json["name"],
        price: json["price"],
        count: json['count']??0,
        instock: json["instock"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "instock": instock,
      };
}

