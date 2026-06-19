class PaymentOrderDraft {
  const PaymentOrderDraft({
    required this.explainQuantity,
    required this.cvScanQuantity,
    required this.explainCredits,
    required this.cvScanCredits,
    required this.amount,
  });

  factory PaymentOrderDraft.fromUri(Uri uri) {
    final params = uri.queryParameters;

    return PaymentOrderDraft(
      explainQuantity: _readPositiveInt(params['explainQuantity']),
      cvScanQuantity: _readPositiveInt(params['cvScanQuantity']),
      explainCredits: _readPositiveInt(params['explainCredits']),
      cvScanCredits: _readPositiveInt(params['cvScanCredits']),
      amount: _readPositiveInt(params['amount']),
    );
  }

  final int explainQuantity;
  final int cvScanQuantity;
  final int explainCredits;
  final int cvScanCredits;
  final int amount;

  bool get isValid {
    return amount > 0 &&
        explainQuantity + cvScanQuantity > 0 &&
        explainCredits >= 0 &&
        cvScanCredits >= 0;
  }
}

class PaymentOrder {
  const PaymentOrder({
    required this.id,
    required this.addInfo,
    required this.amount,
    required this.explainQuantity,
    required this.cvScanQuantity,
    required this.explainCredits,
    required this.cvScanCredits,
  });

  final String id;
  final String addInfo;
  final int amount;
  final int explainQuantity;
  final int cvScanQuantity;
  final int explainCredits;
  final int cvScanCredits;

  int get totalCredits => explainCredits + cvScanCredits;

  String get packageName {
    final parts = <String>[];
    if (explainCredits > 0) {
      parts.add('$explainCredits lượt giải thích');
    }
    if (cvScanCredits > 0) {
      parts.add('$cvScanCredits lượt scan CV');
    }

    return parts.join(' + ');
  }

  String get qrUrl {
    return Uri.https(
      'img.vietqr.io',
      '/image/tpbank-00001074046-compact2.jpg',
      {
        'amount': amount.toString(),
        'addInfo': addInfo,
        'accountName': 'PHAM NGOC HUY',
      },
    ).toString();
  }
}

int _readPositiveInt(String? value) {
  if (value == null) {
    return 0;
  }

  final parsed = int.tryParse(value);
  if (parsed == null || parsed < 0) {
    return 0;
  }

  return parsed;
}
