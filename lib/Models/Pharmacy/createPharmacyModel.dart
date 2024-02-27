class CreatePharmacyModel {
  String? message;
  Pharmacy? pharmacy;

  CreatePharmacyModel({this.message, this.pharmacy});

  CreatePharmacyModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    pharmacy = json['pharmacy'] != null
        ? new Pharmacy.fromJson(json['pharmacy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.pharmacy != null) {
      data['pharmacy'] = this.pharmacy!.toJson();
    }
    return data;
  }
}

class Pharmacy {
  RegistrationDate? registrationDate;
  int? validation;
  int? id;
  String? fullName;
  String? mobileNumber;
  String? email;
  String? pharmacyNo;
  String? pharmacistId;
  String? address;
  String? city;
  String? state;

  Pharmacy(
      {this.registrationDate,
        this.validation,
        this.id,
        this.fullName,
        this.mobileNumber,
        this.email,
        this.pharmacyNo,
        this.pharmacistId,
        this.address,
        this.city,
        this.state});

  Pharmacy.fromJson(Map<String, dynamic> json) {
    registrationDate = json['registrationDate'] != null
        ? new RegistrationDate.fromJson(json['registrationDate'])
        : null;
    validation = json['validation'];
    id = json['id'];
    fullName = json['fullName'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    pharmacyNo = json['pharmacy_no'];
    pharmacistId = json['pharmacist_id'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.registrationDate != null) {
      data['registrationDate'] = this.registrationDate!.toJson();
    }
    data['validation'] = this.validation;
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['pharmacy_no'] = this.pharmacyNo;
    data['pharmacist_id'] = this.pharmacistId;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}
class RegistrationDate {
  String? fn;
  List<String>? args;

  RegistrationDate({this.fn, this.args});

  RegistrationDate.fromJson(Map<String, dynamic> json) {
    fn = json['fn'];
    if (json['args'] != null) {
      args = <String>[];
      json['args'].forEach((v) {
        args!.add(v as String);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fn'] = this.fn;
    if (this.args != null) {
      data['args'] = this.args!.map((v) => v).toList();
    }
    return data;
  }
}