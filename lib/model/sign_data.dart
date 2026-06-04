class SignData {

  final String? sign;
  final String? icon;

  SignData({
    required this.icon,

    required this.sign,
  });

  factory SignData.fromJson(Map<String, dynamic> json) {
    return SignData(
      icon: json['icon'],
      sign: json['sign'],
    );
  }
}