class expList {
  static int _minPoints = 120;
  Map<String, List> Catalog = {
    'Swimming Pool': [
      _minPoints * 0.8,
      'Parco Acquatico SplashFun',
      '10% discount'
    ],
    'Rafting Adventure': [
      _minPoints * 2,
      'Valbrenta Sport Fluviali',
      '10% discount on equipement'
    ],
    'Climbing': [
      _minPoints * 4,
      'Associazione Arrampicata Sportiva Padova A. S. D.',
      '1st hour free'
    ],
    'Trekking Trip': [_minPoints * 3, 'meeters.org', '30% discount on lunch'],
    'Paragliding': [_minPoints * 6, 'Montegrappa Tandem Team', '10% discount'],
    'Bungee Jumping': [
      _minPoints * 50,
      'Valgadena Bungee Center',
      'Free video'
    ],
  };
}
