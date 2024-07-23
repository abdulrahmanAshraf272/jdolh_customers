class Bill {
  String? bchName;
  String? brandName;
  String? bchLocation;
  int? resUserid;
  int? billId;
  int? billResid;
  int? billBrandId;
  int? billBchId;
  int? billUserid;
  String? billTaxPercent;
  String? billTaxAmount;
  String? billAmountWithoutTax;
  String? billAmount;
  String? billFile;
  int? billIsPayed;
  String? billPaymentMethod;
  String? billVatNo;
  String? billCreatetime;

  Bill(
      {this.bchName,
      this.brandName,
      this.bchLocation,
      this.resUserid,
      this.billId,
      this.billResid,
      this.billBrandId,
      this.billBchId,
      this.billUserid,
      this.billTaxPercent,
      this.billTaxAmount,
      this.billAmountWithoutTax,
      this.billAmount,
      this.billFile,
      this.billIsPayed,
      this.billPaymentMethod,
      this.billVatNo,
      this.billCreatetime});

  Bill.fromJson(Map<String, dynamic> json) {
    bchName = json['bch_branchName'];
    brandName = json['brand_storeName'];
    bchLocation = json['bch_location'];
    resUserid = json['res_userid'];
    billId = json['bill_id'];
    billResid = json['bill_resid'];
    billBrandId = json['bill_brandId'];
    billBchId = json['bill_bchId'];
    billUserid = json['bill_userid'];
    billTaxPercent = json['bill_taxPercent'];
    billTaxAmount = json['bill_taxAmount'];
    billAmountWithoutTax = json['bill_amountWithoutTax'];
    billAmount = json['bill_amount'];
    billFile = json['bill_file'];
    billIsPayed = json['bill_isPayed'];
    billPaymentMethod = json['bill_paymentMethod'];
    billVatNo = json['bill_vatNo'];
    billCreatetime = json['bill_createtime'];
  }
}
