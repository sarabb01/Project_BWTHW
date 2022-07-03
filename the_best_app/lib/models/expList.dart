/* This class contains a Map with the experiences. 
Key: name of the experience
Value: details of the experience
*/

class expList {
  static double _minPoints = 15.0;
  //static double _minPoints = 0.0;
  Map<String, List> Catalog = {
    'Swimming Pool': [
      _minPoints * 0.8,
      'Parco Acquatico SplashFun',
      '10% discount',
      'assets/QRcodes/FunnySplash.png',
      'assets/Images/sports.png'
    ],
    'Rafting Adventure': [
      _minPoints * 2,
      'Valbrenta Sport Fluviali',
      '10% discount on equipement',
      'assets/QRcodes/Rafting.png',
      'assets/Images/sports.png'
    ],
    'Climbing': [
      _minPoints * 4,
      'Associazione Arrampicata Sportiva Padova A. S. D.',
      '1st hour free',
      'assets/QRcodes/Arrampicata.png',
      'assets/Images/sports.png'
    ],
    'Trekking Trip': [
      _minPoints * 3,
      'Rifugi in Rete',
      '30% discount on lunch',
      'assets/QRcodes/Rifugio.png',
      'assets/Images/sports.png'
    ],
    'Paragliding': [
      _minPoints * 6,
      'Montegrappa Tandem Team',
      '10% discount',
      'assets/QRcodes/Paragliding.png',
      'assets/Images/sports.png'
    ],
    'Bungee Jumping': [
      _minPoints * 50,
      'Valgardena Bungee Center',
      'Free video',
      'assets/QRcodes/bungee.png',
      'assets/Images/sports.png'
    ],
  };
}
