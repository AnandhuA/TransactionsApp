class AccountStatement {
  String maskedAccount;
  String linkRefNum;
  Account account;

  AccountStatement({
    required this.maskedAccount,
    required this.linkRefNum,
    required this.account,
  });

  factory AccountStatement.fromJson(Map<String, dynamic> json) {
    return AccountStatement(
      maskedAccount: json['masked_account'],
      linkRefNum: json['link_ref_num'],
      account: Account.fromJson(json['decrypted_data']['Account']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'masked_account': maskedAccount,
      'link_ref_num': linkRefNum,
      'decrypted_data': {
        'Account': account.toJson(),
      },
    };
  }
}

class Account {
  String type;
  String maskedAccNumber;
  String version;
  String linkedAccRef;
  Profile profile;
  Summary summary;
  Transactions transactions;

  Account({
    required this.type,
    required this.maskedAccNumber,
    required this.version,
    required this.linkedAccRef,
    required this.profile,
    required this.summary,
    required this.transactions,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      type: json['type'] ?? "",
      maskedAccNumber: json['maskedAccNumber'] ?? "",
      version: json['version'] ?? "",
      linkedAccRef: json['linkedAccRef'] ?? "",
      profile: Profile.fromJson(json['Profile']),
      summary: Summary.fromJson(json['Summary']),
      transactions: Transactions.fromJson(json['Transactions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'maskedAccNumber': maskedAccNumber,
      'version': version,
      'linkedAccRef': linkedAccRef,
      'Profile': profile.toJson(),
      'Summary': summary.toJson(),
      'Transactions': transactions.toJson(),
    };
  }
}

class Profile {
  Holders holders;

  Profile({
    required this.holders,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      holders: Holders.fromJson(json['Holders']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Holders': holders.toJson(),
    };
  }
}

class Holders {
  String type;
  Holder holder;

  Holders({
    required this.type,
    required this.holder,
  });

  factory Holders.fromJson(Map<String, dynamic> json) {
    return Holders(
      type: json['type'],
      holder: Holder.fromJson(json['Holder']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'Holder': holder.toJson(),
    };
  }
}

class Holder {
  String name;
  String dob;
  String mobile;
  String nominee;
  String landline;
  String address;
  String email;
  String pan;
  bool ckycCompliance;

  Holder({
    required this.name,
    required this.dob,
    required this.mobile,
    required this.nominee,
    required this.landline,
    required this.address,
    required this.email,
    required this.pan,
    required this.ckycCompliance,
  });

  factory Holder.fromJson(Map<String, dynamic> json) {
    return Holder(
      name: json['name'] ?? '',
      dob: json['dob'] ?? '',
      mobile: json['mobile'] ?? '',
      nominee: json['nominee'] ?? '',
      landline: json['landline'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      pan: json['pan'] ?? '',
      ckycCompliance: json['ckycCompliance'] == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dob': dob,
      'mobile': mobile,
      'nominee': nominee,
      'landline': landline,
      'address': address,
      'email': email,
      'pan': pan,
      'ckycCompliance': ckycCompliance,
    };
  }
}

class Summary {
  String currentBalance;
  String currency;
  String exchgeRate;
  String balanceDateTime;
  String type;
  String branch;
  String facility;
  String ifscCode;
  String micrCode;
  String openingDate;
  String currentODLimit;
  String drawingLimit;
  String status;
  Pending pending;

  Summary({
    required this.currentBalance,
    required this.currency,
    required this.exchgeRate,
    required this.balanceDateTime,
    required this.type,
    required this.branch,
    required this.facility,
    required this.ifscCode,
    required this.micrCode,
    required this.openingDate,
    required this.currentODLimit,
    required this.drawingLimit,
    required this.status,
    required this.pending,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      currentBalance: json['currentBalance'] ?? '',
      currency: json['currency'] ?? '',
      exchgeRate: json['exchgeRate'] ?? '',
      balanceDateTime: json['balanceDateTime'] ?? '',
      type: json['type'] ?? '',
      branch: json['branch'] ?? '',
      facility: json['facility'] ?? '',
      ifscCode: json['ifscCode'] ?? '',
      micrCode: json['micrCode'] ?? '',
      openingDate: json['openingDate'] ?? '',
      currentODLimit: json['currentODLimit'] ?? '',
      drawingLimit: json['drawingLimit'] ?? '',
      status: json['status'] ?? '',
      pending: Pending.fromJson(json['Pending']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentBalance': currentBalance,
      'currency': currency,
      'exchgeRate': exchgeRate,
      'balanceDateTime': balanceDateTime,
      'type': type,
      'branch': branch,
      'facility': facility,
      'ifscCode': ifscCode,
      'micrCode': micrCode,
      'openingDate': openingDate,
      'currentODLimit': currentODLimit,
      'drawingLimit': drawingLimit,
      'status': status,
      'Pending': pending.toJson(),
    };
  }
}

class Pending {
  String transactionType;
  String amount;

  Pending({
    required this.transactionType,
    required this.amount,
  });

  factory Pending.fromJson(Map<String, dynamic> json) {
    return Pending(
      transactionType: json['transactionType'] ?? '',
      amount: json['amount'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionType': transactionType,
      'amount': amount,
    };
  }
}

class Transactions {
  String startDate;
  String endDate;
  List<Transaction> transactionList;

  Transactions({
    required this.startDate,
    required this.endDate,
    required this.transactionList,
  });

  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      transactionList: List<Transaction>.from(
        json['Transaction'].map((x) => Transaction.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'Transaction': List<dynamic>.from(transactionList.map((x) => x.toJson())),
    };
  }
}

class Transaction {
  String type;
  String mode;
  String amount;
  String currentBalance;
  String transactionTimestamp;
  String valueDate;
  String txnId;
  String narration;
  String reference;

  Transaction({
    required this.type,
    required this.mode,
    required this.amount,
    required this.currentBalance,
    required this.transactionTimestamp,
    required this.valueDate,
    required this.txnId,
    required this.narration,
    required this.reference,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: json['type'] ?? '',
      mode: json['mode'] ?? '',
      amount: json['amount'] ?? '',
      currentBalance: json['currentBalance'] ?? '',
      transactionTimestamp: json['transactionTimestamp'] ?? '',
      valueDate: json['valueDate'] ?? '',
      txnId: json['txnId'] ?? '',
      narration: json['narration'] ?? '',
      reference: json['reference'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'mode': mode,
      'amount': amount,
      'currentBalance': currentBalance,
      'transactionTimestamp': transactionTimestamp,
      'valueDate': valueDate,
      'txnId': txnId,
      'narration': narration,
      'reference': reference,
    };
  }
}
