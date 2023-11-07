import 'package:flutter/material.dart';
import 'package:m_hike/model/hike.dart';
import 'package:m_hike/sql_helper.dart';
import 'package:m_hike/widget/hike_item_widget.dart';
import 'package:m_hike/widget/hike_model_bottom.dart';

class HikePage extends StatefulWidget {
  const HikePage({Key? key}) : super(key: key);

  @override
  State<HikePage> createState() => _HomePageState();
}

class _HomePageState extends State<HikePage> {
  SQLHelper sqlHelper = SQLHelper();
  List<Hike> lstHikes = [];

  void _refreshHikes() async {
    List<Map<String, dynamic>> dataList = await sqlHelper.getHikes();
    List<Hike> itemList = dataList.map((data) => Hike.fromMap(data)).toList();
    setState(() {
      lstHikes = itemList;
      if (lstHikes.isEmpty) {
        _populateHikes();
      }
      Hike.nextId = lstHikes.first.id;
    });
  }

  void _populateHikes() {
    List<Hike> lstAddHikes = [
      Hike(
          name: 'Hike 1',
          location: 'Location 1',
          latitude: 1.0,
          longitude: 1.0,
          date: DateTime.now(),
          parkingAvailable: 'yes',
          length: 10.0,
          difficultyLevel: 'Easy',
          description: 'Description 1'),
      Hike(
          name: 'Hike 2',
          location: 'Location 2',
          latitude: 2.0,
          longitude: 2.0,
          date: DateTime.now(),
          parkingAvailable: 'no',
          length: 20.0,
          difficultyLevel: 'Easy',
          description: 'Description 2'),
      Hike(
          name: 'Hike 3',
          location: 'Location 3',
          latitude: 3.0,
          longitude: 3.0,
          date: DateTime.now(),
          parkingAvailable: 'yes',
          length: 30.0,
          difficultyLevel: 'Easy',
          description: 'Description 3'),
      Hike(
          name: 'Hike 4',
          location: 'Location 4',
          latitude: 4.0,
          longitude: 4.0,
          date: DateTime.now(),
          parkingAvailable: 'no',
          length: 40.0,
          difficultyLevel: 'Easy',
          description: 'Description 4'),
    ];
    for (var hike in lstAddHikes) {
      _handleAddHike(hike);
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshHikes();
    print("Number of hikes: ${lstHikes.length}");
  }

  void _handleAddHike(Hike hike) async {
    await sqlHelper.insertHike(hike.toMap());
    setState(() {
      lstHikes.insert(0, hike);
    });
  }

  void _showEditBottomSheet(Hike hike) {
    showModalBottomSheet(
        backgroundColor: Colors.grey[200],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return HikeModelBottom(manageHike: _handleEditHike, hike: hike);
        });
  }

  void _handleEditHike(Hike hike) async {
    await sqlHelper.updateHike(hike.toMap());
    setState(() {
      final index = lstHikes.indexWhere((element) => element.id == hike.id);
      if (index != -1) {
        lstHikes[index] = hike;
      }
    });
  }

  void _handleDeleteHike(int id) async {
    await sqlHelper.deleteHike(id);
    setState(() {
      lstHikes.removeWhere((element) => element.id == id);
    });
  }

  double _calculateTotalLength() {
    double totalLength = 0.0;
    for (var hike in lstHikes) {
      totalLength += hike.length;
    }
    return totalLength;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hike Management'),
          backgroundColor: const Color(0xFFEF5350),
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Container(
                        height: 100,
                        color: const Color(0xFFF9DEDC),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                lstHikes.length.toString(),
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Color(0xFF4B4B4B),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(
                              'Total Hike',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF4B4B4B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Container(
                        height: 100,
                        color: const Color(0xFFFFD8E4),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                '${_calculateTotalLength()} km',
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Color(0xFF4B4B4B),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(
                              'Total Length',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF4B4B4B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1, // Thickness of the divider
              color: Colors.grey, // Color of the divider
              height: 10, // Margin from the top
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: DropdownButton<String>(
                      items: <String>['Item 1', 'Item 2'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle dropdown value changes
                      },
                      value: 'Item 1', // Set the default value
                    ),
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, right: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search Hike',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  child: Text(
                    'Recent Hikes',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4B4B4B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Add more widgets if needed
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: lstHikes
                        .map((hike) => HikeItem(
                              hike: hike,
                              showEdit: _showEditBottomSheet,
                              handleDelete: _handleDeleteHike,
                            ))
                        .toList(),
                  )),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            showModalBottomSheet(
                backgroundColor: Colors.grey[200],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return HikeModelBottom(
                      manageHike: _handleAddHike, hike: null);
                });
          },
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ));
  }
}
