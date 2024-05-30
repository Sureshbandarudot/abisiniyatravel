class BaseSingleton {
  static final BaseSingleton _singleton = BaseSingleton._internal();
  final int value = 42;
  final String Appname = 'Abisiniya suresh bandaru through singleton class';
   //final String AbisiniyaBaseurl = 'https://staging.abisiniya.com/api/v1/';
   final String AbisiniyaBaseurl = 'https://abisiniya.com/api/v1/';

  //final baseDioSingleton = BaseSingleton();
  //https://staging.abisiniya.com/public/
  factory BaseSingleton() => _singleton;
  BaseSingleton._internal() {
    // private constructor that creates the singleton instance
  }
}


//Usage
//  final baseDioSingleton = BaseSingleton();
// print(baseDioSingleton.value);
//   print(baseDioSingleton.Appname);