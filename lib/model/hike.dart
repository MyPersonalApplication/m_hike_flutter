class Hike {
  static int nextId = 0;

  int _id;
  String _name;
  String _location;
  double _latitude;
  double _longitude;
  DateTime _date;
  String _parkingAvailable;
  double _length;
  String _difficultyLevel;
  String _description;

  Hike(
      {required String name,
      required String location,
      required double latitude,
      required double longitude,
      required DateTime date,
      required String parkingAvailable,
      required double length,
      required String difficultyLevel,
      required String description})
      : _id = ++nextId,
        _name = name,
        _location = location,
        _latitude = latitude,
        _longitude = longitude,
        _date = date,
        _parkingAvailable = parkingAvailable,
        _length = length,
        _difficultyLevel = difficultyLevel,
        _description = description;

  Hike.withId(
      {required int id,
      required String name,
      required String location,
      required double latitude,
      required double longitude,
      required DateTime date,
      required String parkingAvailable,
      required double length,
      required String difficultyLevel,
      required String description})
      : _id = id,
        _name = name,
        _location = location,
        _latitude = latitude,
        _longitude = longitude,
        _date = date,
        _parkingAvailable = parkingAvailable,
        _length = length,
        _difficultyLevel = difficultyLevel,
        _description = description;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get location => _location;

  set location(String value) {
    _location = value;
  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  String get parkingAvailable => _parkingAvailable;

  set parkingAvailable(String value) {
    _parkingAvailable = value;
  }

  double get length => _length;

  set length(double value) {
    _length = value;
  }

  String get difficultyLevel => _difficultyLevel;

  set difficultyLevel(String value) {
    _difficultyLevel = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  @override
  String toString() {
    return 'Hike{id: $id, name: $name, location: $location, latitude: $latitude, longitude: $longitude, date: $date, parkingAvailable: $parkingAvailable, length: $length, difficultyLevel: $difficultyLevel, description: $description}';
  }

  // Convert a Hike object into a Map object
  factory Hike.fromMap(Map<String, dynamic> hike) {
    return Hike.withId(
        id: hike['id'],
        name: hike['name'],
        location: hike['location'],
        latitude: hike['latitude'],
        longitude: hike['longitude'],
        date: DateTime.parse(hike['date']),
        parkingAvailable: hike['parking_available'],
        length: hike['length'],
        difficultyLevel: hike['difficulty_level'],
        description: hike['description']);
  }

  // Create a method to convert Hike to a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'date': date.toIso8601String(),
      'parking_available': parkingAvailable,
      'length': length,
      'difficulty_level': difficultyLevel,
      'description': description
    };
  }
}
