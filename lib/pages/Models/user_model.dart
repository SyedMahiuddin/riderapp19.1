
class UserModel {
  String? uid;
  String? name;
  String? image;
  String? varsityName;
  String? hallName;
  int? floor;
  String? roomNumber;
  String? phone;
  String? email;
  int? semester;
  int? year;
  String? department;
  String? bloodGroup;
  int? points;
  int? connections;
  String? facebook;
  String? insta;
  String? linkedIn;
  String? whatsapp;
  String? github;
  int? activeNotification;
  String? password;
  String status;

  UserModel(
      {this.uid,
      this.name,
      this.image,
      this.varsityName,
      this.hallName,
      this.floor,
      this.roomNumber,
      this.phone,
      this.email,
      this.semester,
      this.year,
      this.department,
      this.bloodGroup,
      this.points = 0,
      this.connections = 0,
      this.facebook,
      this.insta,
      this.linkedIn,
      this.whatsapp,
      this.github,
      this.activeNotification = 0,
      this.password,
      this.status = 'user'
      });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'image': image,
      'varsityName': varsityName,
      'hallName': hallName,
      'floor': floor,
      'roomNumber': roomNumber,
      'phone': phone,
      'email': email,
      'semester': semester,
      'year': year,
      'department': department,
      'bloodGroup': bloodGroup,
      'points': points,
      'connections': connections,
      'facebook': facebook,
      'insta': insta,
      'linkedIn': linkedIn,
      'whatsapp': whatsapp,
      'github': github,
      'activeNotification': activeNotification,
      'password': password,
      'status': status,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        uid: map['uid'],
        name: map['name'],
        image: map['image'],
        varsityName: map['varsityName'],
        hallName: map['hallName'],
        floor: map['floor'],
        roomNumber: map['roomNumber'],
        phone: map['phone'],
        email: map['email'],
        semester: map['semester'],
        year: map['year'],
        department: map['department'],
        bloodGroup: map['bloodGroup'],
        points: map['points'],
        connections: map['connections'],
        facebook: map['facebook'],
        insta: map['insta'],
        linkedIn: map['linkedIn'],
        whatsapp: map['whatsapp'],
        github: map['github'],
        activeNotification: map['activeNotification'],
        password: map['password'],
        status: map['status'],
      );
}
