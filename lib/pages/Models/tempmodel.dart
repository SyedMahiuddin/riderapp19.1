/*
class TempModel{
  String? storeAddress;
  String? userAddress;
  String? pickUpTime;
  String? deliveryTime;
  String? distance;
  String? accept;

  TempModel(
      {
        this.storeAddress,
        this.userAddress,
        this.pickUpTime,
        this.deliveryTime,
        this.distance,
        this.accept,
      });
}

*/
class Order {
  final String Shopadress;
  final String Useradress;
  final String Pickuptime;
  final String Deliverytime;
  final String Distance;
  String Bool;
  final String Id;

  Order({
    required  this.Shopadress,
    required  this.Useradress,
    required  this.Pickuptime,
    required  this.Deliverytime,
    required  this.Distance,
    required  this.Bool,
    required  this.Id
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      Shopadress: json['shopadress'],
      Useradress: json['useradress'],
      Pickuptime: json['pickuptime'],
      Deliverytime: json['deliverytime'],
      Distance: json['distance'],
      Bool: json['bool'],
      Id: json['id'],
    );
  }

}