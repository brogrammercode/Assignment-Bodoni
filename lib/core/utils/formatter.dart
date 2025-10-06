import 'dart:math';

class Formatter {
  final Random _random = Random();

  String generateId({required String value}) {
    final millis = DateTime.now().millisecondsSinceEpoch;
    final hash = value.hashCode.abs().toRadixString(16);
    return "$hash$millis";
  }

  String generateName({required String value}) {
    if (!value.contains('@')) return value;
    return value.split('@').first;
  }

  String generateUsername({required String value}) {
    final base = generateName(value: value);
    final template =
        _usernameTemplates[_random.nextInt(_usernameTemplates.length)];
    return "$base$template";
  }

  static const List<String> _usernameTemplates = [
    "_flashy",
    "_sid",
    "_dark",
    "_knight",
    "_warrior",
    "_xoxo",
    "_lolz",
    "_ninja",
    "_ghost",
    "_hunter",
    "_slayer",
    "_phoenix",
    "_storm",
    "_wolf",
    "_tiger",
    "_dragon",
    "_lion",
    "_snake",
    "_hawk",
    "_falcon",
    "_eagle",
    "_owl",
    "_panther",
    "_bear",
    "_shark",
    "_octopus",
    "_viper",
    "_cobra",
    "_scorpion",
    "_zeus",
    "_thor",
    "_odin",
    "_loki",
    "_hera",
    "_ares",
    "_apollo",
    "_hermes",
    "_poseidon",
    "_hades",
    "_cerberus",
    "_pegasus",
    "_hydra",
    "_leviathan",
    "_titan",
    "_kraken",
    "_cyclops",
    "_minotaur",
    "_samurai",
    "_ronin",
    "_sensei",
    "_shinobi",
    "_shogun",
    "_kaiser",
    "_emperor",
    "_queen",
    "_king",
    "_prince",
    "_princess",
    "_duke",
    "_lord",
    "_baron",
    "_chief",
    "_captain",
    "_major",
    "_general",
    "_colonel",
    "_admiral",
    "_commander",
    "_pilot",
    "_rider",
    "_driver",
    "_sniper",
    "_archer",
    "_slinger",
    "_thrower",
    "_blaster",
    "_laser",
    "_cyber",
    "_tech",
    "_bot",
    "_droid",
    "_mech",
    "_borg",
    "_matrix",
    "_neo",
    "_morpheus",
    "_trinity",
    "_joker",
    "_bane",
    "_venom",
    "_spidey",
    "_ironman",
    "_batman",
    "_superman",
    "_hulk",
    "_thorx",
    "_cap",
    "_rogue",
    "_stormx",
    "_gambit",
    "_logan",
    "_deadpool",
    "_flash",
    "_arrow",
    "_cyborg",
    "_raven",
  ];
}
