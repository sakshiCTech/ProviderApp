class DocumentModel {
  int id;
  String name;
  String type;
  Providerdocuments providerdocuments;

  DocumentModel({this.id, this.name, this.type, this.providerdocuments});

  DocumentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    providerdocuments = json['providerdocuments'] != null
        ? new Providerdocuments.fromJson(json['providerdocuments'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.providerdocuments != null) {
      data['providerdocuments'] = this.providerdocuments.toJson();
    }
    return data;
  }
}

class Providerdocuments {
  String url;
  String status;
  int documentId;

  Providerdocuments({this.url, this.status, this.documentId});

  Providerdocuments.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    status = json['status'];
    documentId = json['document_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['status'] = this.status;
    data['document_id'] = this.documentId;
    return data;
  }
}
