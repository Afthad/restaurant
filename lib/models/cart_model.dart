class CartModel{
  String name;
  int count;
  int price;
  CartModel({
   required this.count,
      required this.name,
      required this.price,
  });

   Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "instock": true,
        "count":count
      };
}
