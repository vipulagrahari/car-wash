import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:web_app/admin_pages/admin_login.dart';
import 'package:web_app/network_utils/network_utils.dart';
import 'package:web_app/user_pages/user_dashboard.dart';
import 'package:web_app/user_pages/user_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class adminDashboard extends StatefulWidget {
  const adminDashboard({super.key});

  @override
  State<adminDashboard> createState() => _adminDashboardState();
}

class _adminDashboardState extends State<adminDashboard> {
  @override
  Widget build(BuildContext context) {
    final placesController = TextEditingController();
    final servicesController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
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
                controller: placesController,
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
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: servicesController,
                decoration: InputDecoration(
                  labelText: "Services",
                  hintText: "Enter Service",
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
              onPressed: () {
                UserNetworkUtilities usern = UserNetworkUtilities();

                var location = {"location": placesController.text};
                usern.addLocation(location);

                var data = {
                  "location": placesController.text,
                  "Service": servicesController.text
                };
                usern.addService(data);
              },
              label: const Text("Add Place"),
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton.extended(
              isExtended: true,
              onPressed: () async {},
              label: const Text("Change Booking Status"),
            ),
          ],
        ),
      ),
    );
  }
}
