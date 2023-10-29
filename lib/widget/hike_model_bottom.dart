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
  // Declare variables to store the user's input
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController parkingAvailableController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController difficultLevelController =
      TextEditingController(text: 'Easy');
  TextEditingController descriptionController = TextEditingController();

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
    if (widget.hike != null) {
      // Handle edit button click and access the form data
      String name = nameController.text;
      String location = locationController.text;
      String latitude = latitudeController.text;
      String longitude = longitudeController.text;
      String parkingAvailable = parkingAvailableController.text;
      String length = lengthController.text;
      String difficultyLevel = difficultLevelController.text;
      String description = descriptionController.text;

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

    // Handle save button click and access the form data
    String name = nameController.text;
    String location = locationController.text;
    String latitude = latitudeController.text;
    String longitude = longitudeController.text;
    String parkingAvailable = parkingAvailableController.text;
    String length = lengthController.text;
    String difficultyLevel = difficultLevelController.text;
    String description = descriptionController.text;

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

    widget.manageHike(hike);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Name Input
            const Text(
              'Name:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Hike Name'),
              controller: nameController,
            ),

            // Location Input
            const SizedBox(height: 20),
            const Text(
              'Location:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Hike Location'),
              controller: locationController,
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
                        const Row(children: [
                          Text(
                            'Latitude:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                        TextField(
                          decoration:
                              const InputDecoration(hintText: 'Hike Latitude'),
                          controller: latitudeController,
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
                        const Row(
                          children: [
                            Text(
                              'Longitude:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        TextField(
                          decoration:
                              const InputDecoration(hintText: 'Hike Longitude'),
                          controller: longitudeController,
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
            const Text(
              'Length',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Hike Length'),
              controller: lengthController,
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
                  value: difficultLevelController.text, // Set the default value
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
    );
  }
}
