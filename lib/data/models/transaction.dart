class Transaction {
  String? transType;
  String? process;
  String? amount;
  String? createtime;

  Transaction({this.transType, this.process, this.amount, this.createtime});

  Transaction.fromJson(Map<String, dynamic> json) {
    transType = json['transType'];
    process = json['process'];
    amount = json['amount'];
    createtime = json['createtime'];
  }
}
