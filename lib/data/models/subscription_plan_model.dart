class SubscriptionPlanModel {
  String? id;
  String? name;
  String? description;
  double? price;
  String? currency;
  String? billingCycle;
  String? storeProductId;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubscriptionPlanModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.currency,
    this.billingCycle,
    this.storeProductId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price']?.toDouble();
    currency = json['currency'];
    billingCycle = json['billing_cycle'];
    storeProductId = json['store_product_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null;
  }
}