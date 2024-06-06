import 'package:flutter/material.dart';
import 'package:sapdos_patient/screens/doctor_detail_screen.dart';
import '../models/doctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorDetailScreen(doctor: doctor)));
      },
      child: Card(
        color: const Color.fromRGBO(240, 242, 245, 1),
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(doctor.doctorImage),
                radius: 30, // Adjusted radius to make it more compact
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize
                      .min, // Make the column as compact as possible
                  children: [
                    Text(
                      doctor.doctorName,
                      style: TextStyle(
                        fontSize: 16, // Adjusted font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      doctor.specialization,
                      style: TextStyle(fontSize: 14), // Adjusted font size
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          size: 16,
                          color: index < 3
                              ? Colors.amber
                              : Colors.grey, // Set the number of filled stars
                        );
                      }),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.calendar_today,
                        size: 20), // Adjusted icon size
                    onPressed: () {
                      // Handle appointment icon press
                    },
                  ),
                  Text(
                    '512',
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey), // Adjusted font size
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
