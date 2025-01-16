class LoginTabletRequest {
  String? unitId;
  String? nik;
  String? shiftId;
  int? loginType;

  LoginTabletRequest(
      {required this.unitId,
      required this.nik,
      required this.shiftId,
      required this.loginType});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unit_id'] = unitId;
    data['nik'] = nik;
    data['shift_id'] = shiftId;
    data['login_type'] = loginType;
    return data;
  }
}
