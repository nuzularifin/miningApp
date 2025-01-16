class LoginAdminRequest {
  String? nik;
  String? password;

  LoginAdminRequest(this.nik, this.password);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nik'] = nik;
    data['password'] = password;
    return data;
  }
}
