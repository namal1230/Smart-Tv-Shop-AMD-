// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RepairRequestModel {
  String? userId;
  String? type;
  String? model;
  String? brand;
  String? description;
  String? status;
  DateTime? date;
  RepairRequestModel({
    this.userId,
    this.type,
    this.model,
    this.brand,
    this.description,
    this.status,
    this.date
  });
  
  

  RepairRequestModel copyWith({
    String? userId,
    String? type,
    String? model,
    String? brand,
    String? description,
    String? status,
    DateTime? date,
  }) {
    return RepairRequestModel(
      userId: userId ?? this.userId,
      type: type ?? this.type,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      description: description ?? this.description,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'type': type,
      'model': model,
      'brand': brand,
      'description': description,
      'status': status,
      'date': date,
    };
  }

  factory RepairRequestModel.fromMap(Map<String, dynamic> map) {
    return RepairRequestModel(
      userId: map['userId'] != null ? map['userId'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      date: map['date'] != null ? map['date'] as DateTime : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RepairRequestModel.fromJson(String source) => RepairRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RepairRequestModel(userId: $userId, type: $type, model: $model, brand: $brand, description: $description, status: $status, date: $date)';
  }

  @override
  bool operator ==(covariant RepairRequestModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.type == type &&
      other.model == model &&
      other.brand == brand &&
      other.description == description &&
      other.status == status &&
      other.date == date;
      
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      type.hashCode ^
      model.hashCode ^
      brand.hashCode ^
      description.hashCode ^
      status.hashCode ^
      date.hashCode;
  }
}
