import 'package:flutter/material.dart';

import 'widgets/boat_widget.dart';
import 'widgets/map_widget.dart';
import 'widgets/vietnam_widget.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Builder(builder: (context) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WorldMapWidget(),
                    ));
                  },
                  child: const Text('World Map'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VietNamWidget(),
                    ));
                  },
                  child: const Text('VietNam Map'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BoatWidget(),
                    ));
                  },
                  child: const Text('Boat'),
                ),
              ],
            ),
          );
        }),
      ),
    ),
  );
}
