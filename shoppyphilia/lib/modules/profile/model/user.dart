
class User {
  User({
      int id, 
      String email, 
      String username, 
      String password, 
      Name name, 
      Address address, 
      String phone,}){
    _id = id;
    _email = email;
    _username = username;
    _password = password;
    _name = name;
    _address = address;
    _phone = phone;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _username = json['username'];
    _password = json['password'];
    _name = json['name'] != null ? Name.fromJson(json['name']) : null;
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _phone = json['phone'];
  }
  int _id;
  String _email;
  String _username;
  String _password;
  Name _name;
  Address _address;
  String _phone;

  int get id => _id;
  String get email => _email;
  String get username => _username;
  String get password => _password;
  Name get name => _name;
  Address get address => _address;
  String get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['username'] = _username;
    map['password'] = _password;
    if (_name != null) {
      map['name'] = _name.toJson();
    }
    if (_address != null) {
      map['address'] = _address.toJson();
    }
    map['phone'] = _phone;
    return map;
  }

}

class Address {
  Address({
      String city, 
      String street, 
      int number, 
      String zipcode, 
      Geolocation geolocation,}){
    _city = city;
    _street = street;
    _number = number;
    _zipcode = zipcode;
    _geolocation = geolocation;
}

  Address.fromJson(dynamic json) {
    _city = json['city'];
    _street = json['street'];
    _number = json['number'];
    _zipcode = json['zipcode'];
    _geolocation = json['geolocation'] != null ? Geolocation.fromJson(json['geolocation']) : null;
  }
  String _city;
  String _street;
  int _number;
  String _zipcode;
  Geolocation _geolocation;

  String get city => _city;
  String get street => _street;
  int get number => _number;
  String get zipcode => _zipcode;
  Geolocation get geolocation => _geolocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = _city;
    map['street'] = _street;
    map['number'] = _number;
    map['zipcode'] = _zipcode;
    if (_geolocation != null) {
      map['geolocation'] = _geolocation.toJson();
    }
    return map;
  }

}

class Geolocation {
  Geolocation({
      String lat, 
      String long,}){
    _lat = lat;
    _long = long;
}

  Geolocation.fromJson(dynamic json) {
    _lat = json['lat'];
    _long = json['long'];
  }
  String _lat;
  String _long;

  String get lat => _lat;
  String get long => _long;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['long'] = _long;
    return map;
  }

}

class Name {
  Name({
      String firstname, 
      String lastname,}){
    _firstname = firstname;
    _lastname = lastname;
}

  Name.fromJson(dynamic json) {
    _firstname = json['firstname'];
    _lastname = json['lastname'];
  }
  String _firstname;
  String _lastname;

  String get firstname => _firstname;
  String get lastname => _lastname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    return map;
  }

}