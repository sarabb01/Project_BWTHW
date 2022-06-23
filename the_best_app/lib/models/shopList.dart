import 'dart:ffi';

class shopList {
  static double _minPoints = 120.0;
  Map<String, List> Catalog = {
    'Decathlon': [_minPoints * 1, 'Decathlon', '20% discount'],
    'Non Solo Sport': [_minPoints * 1.5, 'Non Solo Sport', '20% discount'],
    'Sportler': [_minPoints * 2, 'Sportler', '15% discount'],
    'Cisalfa Sport': [_minPoints * 2.5, 'Cisalfa Sport', '15% discount'],
    'AW Lab': [_minPoints * 3.5, 'AW Lab', '10% discount'],
    'Foot Locker': [_minPoints * 3.5, 'Foot Locker', '10% discount'],
    'Nike': [_minPoints * 5, 'Nike', '10% discount'],
    'Adidas': [_minPoints * 5, 'Adidas', '10% discount'],
  };
}
