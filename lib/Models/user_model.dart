class User{
  final int? id;
  final String? email;
  final String? username;
  final Name? name;
  final String? password;
  final String? phone;
  final Address? address;

  User({this.id, this.name, this.username, this.email, this.password, this.phone ,this.address});

  factory User.fromJson(Map data){
    Name n = Name();
    Address ad = Address();
    if(data['address'] != null){
      ad = Address.fromJson(data['address']);
    }
    if(data['name'] != null){
      n = Name.fromJson(data['name']);
    }
    return User(
      id: data['id'],
      email: data['email'],
      username: data['username'],
      password: data['password'],
      phone: data['phone'],
      name: n,
      address: ad
    );
  }

  toJson(){
    var ad = {
      "city" :  "",
      "street" :  "",
      "zipcode" : "",
      "number" : "",
      "geolocation" : {"lat": "" , "long" : ""}
    };
    return {
      "id" : id,
      "email" : email,
      "username" : username,
      "password" : password,
      "phone" : phone,
      "name" : name == null ? {"firstname" : "", "lastname" : ""} : name!.toJson(),
      "address" : address == null ? ad : address!.toJson(),
    };
  }
}

class Name{
  final String? firstName;
  final String? lastName;

  Name({this.firstName, this.lastName});
  factory Name.fromJson(Map data){
    return Name(
      firstName: data['firstname'],
      lastName: data['lastname'],
    );
  }

  toJson(){
    return {
      "firstname" : firstName,
      "lastname" : lastName,
    };
  }
}

class Address{
  final String? city;
  final String? street;
  final String? number;
  final String? zipCode;
  final GeoLocation? geoLocation;

  Address({this.city, this.street, this.number, this.zipCode, this.geoLocation});


  factory Address.fromJson(Map data){
    GeoLocation geo = GeoLocation();
    if(data['geolocation'] != null){
      geo = GeoLocation.fromJson(data['geolocation']);
    }
    return Address(
      city: data['city'],
      street: data['street'],
      zipCode: data['zipCode'],
      number: data['number'].toString(),
      geoLocation: geo
    );
  }

  toJson(){

    return {
      "city" : city ?? "",
      "street" : street ?? "",
      "zipcode" : zipCode ?? "",
      "number" : number ?? "",
      "geolocation" : geoLocation == null ? {"lat": "" , "long" : ""} : geoLocation!.toJson()
    };
  }
}

class GeoLocation{
  final String? lat;
  final String? long;

  GeoLocation({this.lat, this.long});

  factory GeoLocation.fromJson(Map data){
    return GeoLocation(
      lat: data['lat'],
      long: data['long'],
    );
  }

  toJson(){
    return {
      "lat" : lat ?? "",
      "long" : long ?? "",
    };
  }
}