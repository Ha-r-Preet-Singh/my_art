class UserModel {
  String? uid;
  String? name;
  String? email;
  String? gender;
  String? dob;
  String? address;
  String? mobNo;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.gender,
      this.dob,
      this.address,
      this.mobNo});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel();
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "gender": gender,
      "dob": dob,
      "address": address,
      "mobNo": mobNo,
    };
  }
}
