class Transaction {
  String? transType;
  String? process;
  String? amount;
  String? createtime;
  String? username;

  Transaction(
      {this.transType,
      this.process,
      this.amount,
      this.createtime,
      this.username});

  Transaction.fromJson(Map<String, dynamic> json) {
    transType = json['transType'];
    process = json['process'];
    amount = json['amount'];
    createtime = json['createtime'];
    username = json['username'];
  }
}
