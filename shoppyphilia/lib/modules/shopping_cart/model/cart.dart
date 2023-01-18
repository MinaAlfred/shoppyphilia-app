class Cart {
  Cart({
    num id,
    num userId,
    String date,
    List<Products> products,
    num v,
  }) {
    _id = id;
    _userId = userId;
    _date = date;
    _products = products;
    _v = v;
  }

  Cart.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _date = json['date'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products.add(Products.fromJson(v));
      });
    }
    _v = json['__v'];
  }
  num _id;
  num _userId;
  String _date;
  List<Products> _products;
  num _v;

  num get id => _id;
  num get userId => _userId;
  String get date => _date;
  List<Products> get products => _products;
  num get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['date'] = _date;
    if (_products != null) {
      map['products'] = _products.map((v) => v.toJson()).toList();
    }
    map['__v'] = _v;
    return map;
  }
}

class Products {
  num productId;
  num quantity;
  String name;
  num price;
  Products({num productId, num quantity, String name, num price});

  Products.fromJson(dynamic json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    map['quantity'] = quantity;
    return map;
  }
}
