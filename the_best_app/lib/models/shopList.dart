import 'dart:ffi';

class shopList {
  //static double _minPoints = 100.0;
  static double _minPoints = 0.0;
  Map<String, List> Catalog = {
    'Decathlon': [
      _minPoints * 1,
      'Decathlon',
      '20% discount',
      'assets/QRcodes/Decathlon.png',
      'assets/Images/shopping.png'
    ],
    'Non Solo Sport': [
      _minPoints * 1.5,
      'Non Solo Sport',
      '20% discount',
      'assets/QRcodes/NonSoloSport.png',
      'assets/Images/shopping.png'
    ],
    'Sportler': [
      _minPoints * 2,
      'Sportler',
      '15% discount',
      'assets/QRcodes/Sportler.png',
      'assets/Images/shopping.png'
    ],
    'Cisalfa Sport': [
      _minPoints * 2.5,
      'Cisalfa Sport',
      '15% discount',
      'assets/QRcodes/Cisalfa.png',
      'assets/Images/shopping.png'
    ],
    'AW Lab': [
      _minPoints * 3.5,
      'AW Lab',
      '10% discount',
      'assets/QRcodes/AWLab.png',
      'assets/Images/shopping.png'
    ],
    'Foot Locker': [
      _minPoints * 3.5,
      'Foot Locker',
      '10% discount',
      'assets/QRcodes/Footlocker.png',
      'assets/Images/shopping.png'
    ],
    'Nike': [_minPoints * 5, 'Nike', '10% discount', 'assets/QRcodes/Nike.png'],
    'Adidas': [
      _minPoints * 5,
      'Adidas',
      '10% discount',
      'assets/QRcodes/Adidas.png',
      'assets/Images/shopping.png'
    ],
  };
}
