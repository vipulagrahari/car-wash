import 'package:flutter/material.dart';
import 'package:web_app/network_utils/network_utils.dart';
import 'package:web_app/user_pages/user_search.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    String place = "";

    final searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("User Dashboard"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: "Place",
                  hintText: "Enter Place",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your Place";
                  }
                  return null;
                },
              ),
            ),
            FloatingActionButton.extended(
              isExtended: true,
              onPressed: () async {
                var data = await getData(searchController.text);

                setState(() {
                  place = data;
                });
                // Navigator.push<void>(
                //   context,
                //   MaterialPageRoute<void>(
                //       builder: (BuildContext context) =>
                //           userSearch(places: searchController.text)),
                // );
              },
              label: Text("Search for Places"),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("The place Exists as: $place"),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton.extended(
              isExtended: true,
              onPressed: () {},
              label: const Text("Get Booking Status"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> getData(String place) {
  UserNetworkUtilities nh = UserNetworkUtilities();

  var x = nh.getSearch(place);
  return x;
}
