class GetAllPharmacyModel {
  int? id;
  String? fullName;
  String? mobileNumber;
  String? email;
  String? address;
  String? city;
  String? state;
  String? pharmacyNo;
  dynamic pharmacyCertificate;
  dynamic pharmacyPhoto;
  String? registrationDate;
  int? pharmacistId;
  int? validation;
  Pharmacist? pharmacist;

  GetAllPharmacyModel({
    this.id,
    this.fullName,
    this.mobileNumber,
    this.email,
    this.address,
    this.city,
    this.state,
    this.pharmacyNo,
    this.pharmacyCertificate,
    this.pharmacyPhoto,
    this.registrationDate,
    this.pharmacistId,
    this.validation,
    this.pharmacist,
  });

  factory GetAllPharmacyModel.fromJson(Map<String, dynamic> json) {
    return GetAllPharmacyModel(
      id: json['id'],
      fullName: json['fullName'],
      mobileNumber: json['mobileNumber'],
      email: json['email'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      pharmacyNo: json['pharmacyNo'],
      pharmacyCertificate: json['pharmacyCertificate'],
      pharmacyPhoto: json['pharmacyPhoto'],
      registrationDate: json['registrationDate'],
      pharmacistId: json['pharmacistId'],
      validation: json['validation'],
      pharmacist: json['pharmacist'] != null ? Pharmacist.fromJson(json['pharmacist']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pharmacyNo'] = this.pharmacyNo;
    data['pharmacyCertificate'] = this.pharmacyCertificate;
    data['pharmacyPhoto'] = this.pharmacyPhoto;
    data['registrationDate'] = this.registrationDate;
    data['pharmacistId'] = this.pharmacistId;
    data['validation'] = this.validation;
    if (this.pharmacist != null) {
      data['pharmacist'] = this.pharmacist!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'GetAllPharmacyModel{id: $id, fullName: $fullName, mobileNumber: $mobileNumber, email: $email, address: $address, city: $city, state: $state, pharmacyNo: $pharmacyNo, pharmacyCertificate: $pharmacyCertificate, pharmacyPhoto: $pharmacyPhoto, registrationDate: $registrationDate, pharmacistId: $pharmacistId, validation: $validation, pharmacist: $pharmacist}';
  }
}
class Pharmacist {
  int? id;
  String? fullName;
  String? mobileNumber;
  String? email;
  String? pharmacistLiscence;
  Null? pharmacistCertificate;
  Null? pharmacistPhoto;
  String? registrationDate;

  Pharmacist({
    this.id,
    this.fullName,
    this.mobileNumber,
    this.email,
    this.pharmacistLiscence,
    this.pharmacistCertificate,
    this.pharmacistPhoto,
    this.registrationDate,
  });

  factory Pharmacist.fromJson(Map<String, dynamic> json) {
    return Pharmacist(
      id: json['id'],
      fullName: json['fullName'],
      mobileNumber: json['mobileNumber'],
      email: json['email'],
      pharmacistLiscence: json['pharmacist_liscence'],
      pharmacistCertificate: json['pharmacist_certificate'],
      pharmacistPhoto: json['pharmacist_photo'],
      registrationDate: json['registrationDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['pharmacist_liscence'] = this.pharmacistLiscence;
    data['pharmacist_certificate'] = this.pharmacistCertificate;
    data['pharmacist_photo'] = this.pharmacistPhoto;
    data['registrationDate'] = this.registrationDate;
    return data;
  }
}