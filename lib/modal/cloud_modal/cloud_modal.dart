class UserModalData {
  String? name, email,image, phone, token;

  UserModalData(
      {required this.name,
      required this.email,
        required this.image,

      required this.phone,
      required this.token});

  factory UserModalData.fromMap(Map m1) {
    return UserModalData(
        name: m1['name'],
        email: m1['email'],
        image: m1['image'],

        phone: m1['phone'],
        token: m1['token']);
  }

  Map<String, String?> toMap(UserModalData user) {
    return {
      'name': user.name,
      'email': user.email,
      'image':user.image,
      'phone': user.phone,
      'token': user.token
    };
  }
}
