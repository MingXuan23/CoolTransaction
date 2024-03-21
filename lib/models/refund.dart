class Refund {
  int id;
  String paymentId;
  DateTime requestedDate;
  String requestNo;
  String reason;
  String description;

  Refund({
    required this.id,
    required this.paymentId,
    required this.requestedDate,
    required this.requestNo,
    required this.reason,
    required this.description,
  });
}
