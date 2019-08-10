
class Doughnut {
  String name;
  double price;

  Doughnut(this.name, this.price);

  Doughnut.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'];

  Map<String, dynamic> toJson() => {
    'name' : name,
    'price' : price
  };
}