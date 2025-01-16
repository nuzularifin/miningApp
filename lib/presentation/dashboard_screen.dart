import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_synapsys/core/themes/app_text_styles.dart';
import 'package:flutter_test_synapsys/presentation/bloc/map/map_bloc.dart';
import 'package:flutter_test_synapsys/presentation/bloc/map/map_event.dart';
import 'package:flutter_test_synapsys/presentation/bloc/map/map_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    BlocProvider.of<MapBloc>(context).add(GetMapLocation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            googleMapsContent(),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 200,
                margin: EdgeInsets.only(top: 20),
                color: Colors.black.withOpacity(.5),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ActivityItemContent(label: 'IDLE'),
                    ActivityItemContent(label: 'HAULING'),
                    ActivityItemContent(label: 'LOADING'),
                    ActivityItemContent(label: 'HANGING'),
                    ActivityItemContent(label: 'DUMPING'),
                    ActivityItemContent(label: 'QUEUING'),
                    ActivityItemContent(label: 'MAINTENANCE'),
                  ],
                ),
              ),
            ),
            // Container(
            //   width: 300,
            //   child: overlayContent(),
            // ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 250,
                color: Colors.black.withOpacity(.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InfoCard(
                        title: 'Speed',
                        content: '50 km/h',
                        subtitle: 'Test',
                        color: Colors.black),
                    InfoCard(
                        title: 'Speed',
                        content: '50 km/h',
                        subtitle: 'Test',
                        color: Colors.black),
                    InfoCard(
                        title: 'Speed',
                        content: '50 km/h',
                        subtitle: 'Test',
                        color: Colors.black),
                    InfoCard(
                        title: 'Speed',
                        content: '50 km/h',
                        subtitle: 'Test',
                        color: Colors.black),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                color: Colors.grey.shade500,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'EMERGENCY',
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'BREAKDOWN',
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          iconSize: 45,
                          color: Colors.white,
                          icon: const Icon(Icons.settings),
                          tooltip: 'Increase volume by 10',
                          onPressed: () {},
                        ),
                        IconButton(
                          iconSize: 45,
                          color: Colors.white,
                          icon: const Icon(Icons.system_update_alt_sharp),
                          tooltip: 'Increase volume by 10',
                          onPressed: () {},
                        ),
                        IconButton(
                          iconSize: 45,
                          color: Colors.white,
                          icon: const Icon(Icons.mail_outline_outlined),
                          tooltip: 'Increase volume by 10',
                          onPressed: () {},
                        ),
                        IconButton(
                          iconSize: 45,
                          color: Colors.white,
                          icon: const Icon(Icons.menu),
                          tooltip: 'Increase volume by 10',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget googleMapsContent() => Container(
        child: BlocConsumer<MapBloc, MapState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MapLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MapError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error fetching map data'),
                    SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<MapBloc>(context)
                              .add(GetMapLocation());
                        },
                        child: Text('Retry'))
                  ],
                ),
              );
            }

            if (state is MapLoaded) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(state.latitude, state.longitude), zoom: 14),
                markers: {
                  Marker(
                      markerId: const MarkerId('current'),
                      position: LatLng(state.latitude, state.longitude))
                },
              );
            }

            return Container();
          },
        ),
      );

  Widget contentCardLeft() => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.black,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.speed,
                    color: Colors.white,
                  ),
                  Text(
                    'Speed',
                    style: AppTextStyles.labelSmall16,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.red,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '75 \nkm/h',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.labelSmall16,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class ActivityItemContent extends StatelessWidget {
  final String label;
  const ActivityItemContent({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        label,
        style: AppTextStyles.labelSmall16,
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final String subtitle;
  final Color color;

  const InfoCard({
    required this.title,
    required this.content,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(content, style: TextStyle(fontSize: 20, color: color)),
              Text(subtitle, textAlign: TextAlign.right),
            ],
          ),
        ],
      ),
    );
  }
}
