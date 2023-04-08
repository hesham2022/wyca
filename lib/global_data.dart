final kLocations = ['Egypt, Mansoura', 'Egypt, Cairo', 'Egypt, Aswan'];

class CreditCard {
  CreditCard({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvvCode,
    required this.type,
  });

  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvvCode;
  final String type;
}

String last4Digits(String cardNumber) {
  return cardNumber.substring(cardNumber.length - 4);
}

final kCrdeitCards = [
  CreditCard(
    type: 'Master Card',
    cardNumber: '1234 5678 9012 3456',
    cardHolderName: 'Mohamed El-Sayed',
    expiryDate: '04/24',
    cvvCode: '123',
  )
];
