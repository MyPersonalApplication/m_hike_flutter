import 'package:flutter/material.dart';
import 'package:m_hike/model/hike.dart';

class HikeModelBottom extends StatefulWidget {
  const HikeModelBottom({
    Key? key,
    required this.manageHike,
    required this.hike,
  }) : super(key: key);

  final Function(Hike) manageHike;
  final Hike? hike;

  @override
  State<HikeModelBottom> createState() => _HikeModelBottomState();
}

class _HikeModelBottomState extends State<HikeModelBottom> {
  // Declare global key for form validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Declare variables to store the user's input
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController parkingAvailableController = TextEditingController(text: 'yes');
  TextEditingController lengthController = TextEditingController();
  TextEditingController difficultLevelController =
      TextEditingController(text: 'Easy');
  TextEditingController descriptionController = TextEditingController();

  // Validation functions for each TextField
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Location is required';
    }
    return null;
  }

  String? validateLatitude(String? value) {
    if (value == null || value.isEmpty) {
      return 'Latitude is required';
    }
    return null;
  }

  String? validateLongitude(String? value) {
    if (value == null || value.isEmpty) {
      return 'Longitude is required';
    }
    return null;
  }

  String? validateParkingAvailable(String? value) {
    if (value == null || value.isEmpty) {
      return 'Parking Available is required';
    }
    return null;
  }

  String? validateLength(String? value) {
    if (value == null || value.isEmpty) {
      return 'Length is required';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    if (widget.hike != null) {
      nameController.text = widget.hike!.name;
      locationController.text = widget.hike!.location;
      latitudeController.text = widget.hike!.latitude.toString();
      longitudeController.text = widget.hike!.longitude.toString();
      parkingAvailableController.text = widget.hike!.parkingAvailable;
      lengthController.text = widget.hike!.length.toString();
      difficultLevelController.text = widget.hike!.difficultyLevel;
      descriptionController.text = widget.hike!.description;
    }
  }

  void _handleOnClicked(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String name = nameController.text;
      String location = locationController.text;
      String latitude = latitudeController.text;
      String longitude = longitudeController.text;
      String parkingAvailable = parkingAvailableController.text;
      String length = lengthController.text;
      String difficultyLevel = difficultLevelController.text;
      String description = descriptionController.text;

      if (widget.hike != null) {
        // Update the hike object
        widget.hike!.name = name;
        widget.hike!.location = location;
        widget.hike!.latitude = double.parse(latitude);
        widget.hike!.longitude = double.parse(longitude);
        widget.hike!.parkingAvailable = parkingAvailable;
        widget.hike!.length = double.parse(length);
        widget.hike!.difficultyLevel = difficultyLevel;
        widget.hike!.description = description;

        widget.manageHike(widget.hike!);
        Navigator.pop(context);
        return;
      }

      // Create a new hike object
      final hike = Hike(
          name: name,
          location: location,
          latitude: double.parse(latitude),
          longitude: double.parse(longitude),
          date: DateTime.now(),
          parkingAvailable: parkingAvailable,
          length: double.parse(length),
          difficultyLevel: difficultyLevel,
          description: description);

      String message = 'Your inputted data:';
      message += '\nName: $name';
      message += '\nLocation: $location';
      message += '\nParking Available: $parkingAvailable';
      message += '\nLength: $length';
      message += '\nDifficulty Level: $difficultyLevel';
      message += '\nDescription: $description';

      // Display the alert dialog to confirm the user's action
      showAlertDialog(context, message, hike);
    }
  }

  showAlertDialog(BuildContext context, String message, Hike hike) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        widget.manageHike(hike);
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirm your hike!"),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Name Input
              TextFormField(
                decoration: const InputDecoration(labelText: 'Hike Name'),
                controller: nameController,
                validator: validateName,
              ),

              // Location Input
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Hike Location'),
                controller: locationController,
                validator: validateLocation,
              ),

              // Latitude and Longitude Inputs
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Hike Latitude'
                            ),
                            controller: latitudeController,
                            validator: validateLatitude,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Hike Longitude'
                            ),
                            controller: longitudeController,
                            validator: validateLongitude,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              // Parking Available
              const SizedBox(height: 20),
              const Text(
                'Parking Available',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio(
                    value: 'yes',
                    groupValue: parkingAvailableController.text,
                    onChanged: (value) {
                      setState(() {
                        parkingAvailableController.text = value.toString();
                      });
                    },
                  ),
                  const Text('Yes'),
                  Radio(
                    value: 'no',
                    groupValue: parkingAvailableController.text,
                    onChanged: (value) {
                      setState(() {
                        parkingAvailableController.text = value.toString();
                      });
                    },
                  ),
                  const Text('No'),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Hike Length'),
                controller: lengthController,
                validator: validateLength,
              ),

              // Difficulty Level Dropdown
              const SizedBox(height: 20),
              const Text(
                'Difficulty Level',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: DropdownButton<String>(
                    items: <String>['Easy', 'Medium', 'Difficult']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        difficultLevelController.text = newValue ?? '';
                      });
                    },
                    value:
                        difficultLevelController.text, // Set the default value
                  ),
                ),
              ),

              // Description Input
              const SizedBox(height: 20),
              const Text(
                'Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                maxLines: 5,
                decoration: const InputDecoration(hintText: 'Hike Description'),
                controller: descriptionController,
              ),

              // Save and Cancel Buttons
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle cancel button click
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _handleOnClicked(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
