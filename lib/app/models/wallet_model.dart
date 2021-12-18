class WalletModel {
  int walletBalance;

  WalletModel({this.walletBalance});

  WalletModel.fromJson(Map<String, dynamic> json) {
    walletBalance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_balance'] = this.walletBalance;
    return data;
  }
}