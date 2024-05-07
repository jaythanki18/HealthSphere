class CommentShowModel {
  List<Comments>? comments;

  CommentShowModel({this.comments});

  CommentShowModel.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  int? id;
  String? description;
  String? createdAt;
  int? postId;
  Pharmacist? pharmacist;

  Comments(
      {this.id,
        this.description,
        this.createdAt,
        this.postId,
        this.pharmacist});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    createdAt = json['createdAt'];
    postId = json['postId'];
    pharmacist = json['pharmacist'] != null
        ? new Pharmacist.fromJson(json['pharmacist'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['postId'] = this.postId;
    if (this.pharmacist != null) {
      data['pharmacist'] = this.pharmacist!.toJson();
    }
    return data;
  }
}

class Pharmacist {
  int? id;
  String? fullName;
  String? email;
  String? mobileNumber;
  Null? pharmacistPhoto;

  Pharmacist(
      {this.id,
        this.fullName,
        this.email,
        this.mobileNumber,
        this.pharmacistPhoto});

  Pharmacist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    pharmacistPhoto = json['pharmacist_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['pharmacist_photo'] = this.pharmacistPhoto;
    return data;
  }
}
