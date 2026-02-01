// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PendingRequestsModel {
  String? type;
  String? description;
  String? customer;
  String? phone;
  String? date;
  PendingRequestsModel({
    this.type,
    this.description,
    this.customer,
    this.phone,
    this.date,
  });

  

  PendingRequestsModel copyWith({
    String? type,
    String? description,
    String? customer,
    String? phone,
    String? date,
  }) {
    return PendingRequestsModel(
      type: type ?? this.type,
      description: description ?? this.description,
      customer: customer ?? this.customer,
      phone: phone ?? this.phone,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'description': description,
      'customer': customer,
      'phone': phone,
      'date': date,
    };
  }

  factory PendingRequestsModel.fromMap(Map<String, dynamic> map) {
    return PendingRequestsModel(
      type: map['type'] != null ? map['type'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      customer: map['customer'] != null ? map['customer'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PendingRequestsModel.fromJson(String source) => PendingRequestsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PendingRequestsModel(type: $type, description: $description, customer: $customer, phone: $phone, date: $date)';
  }

  @override
  bool operator ==(covariant PendingRequestsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.type == type &&
      other.description == description &&
      other.customer == customer &&
      other.phone == phone &&
      other.date == date;
  }

  @override
  int get hashCode {
    return type.hashCode ^
      description.hashCode ^
      customer.hashCode ^
      phone.hashCode ^
      date.hashCode;
  }
}
