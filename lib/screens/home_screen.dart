// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/doctor_bloc.dart';
import '../bloc/doctor_event.dart';
import '../bloc/doctor_state.dart';
import '../models/doctor.dart';
import '../widgets/doctor_card.dart';
import '../widgets/responsive.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: Color.fromRGBO(19, 35, 90, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(),
              child: Text(
                'SAPDOS',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.category, color: Colors.white),
              title: Text(
                'Categories',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              title: Text('Appointment', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.chat, color: Colors.white),
              title: Text('Chat', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text('Settings', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text('Logout', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
      appBar: AppBar(title: Text('SAPDOS')),
      body: BlocProvider(
        create: (context) => DoctorBloc(context.read())..add(LoadDoctors()),
        child: BlocBuilder<DoctorBloc, DoctorState>(
          builder: (context, state) {
            if (state is DoctorsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DoctorsLoaded) {
              final responseData = state.responseData;
              return Column(
                children: [
                  UserGreeting(user: responseData.user),
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    // child: TextField(
                    //   autofocus: false,
                    //   style: TextStyle(
                    //     color: Color.fromRGBO(19, 35, 90, 1),
                    //   ),
                    //   decoration: InputDecoration(
                    //     fillColor: Color.fromRGBO(19, 35, 90, 1),
                    //     border: OutlineInputBorder(),
                    //     labelText: 'Doctor\'s List',
                    //     suffixIcon: Icon(Icons.filter_list),
                    //   ),
                    // ),
                    child: MaterialBanner(
                      content: Text(
                        'Doctor\'s List',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Color.fromRGBO(19, 35, 90, 1),
                      actions: <Widget>[
                        Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Responsive(
                      mobile: DoctorList(doctors: responseData.doctorsList),
                      desktop: DoctorGrid(doctors: responseData.doctorsList),
                    ),
                  ),
                ],
              );
            } else if (state is DoctorsError) {
              return Center(child: Text('Failed to fetch doctors'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class UserGreeting extends StatelessWidget {
  final User user;

  UserGreeting({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.avatar),
            radius: 30,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.greeting,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                user.name,
                style: TextStyle(fontSize: 20),
              )
            ],
          )
          //Text('${user.greeting} ${user.name}'),
        ],
      ),
    );
  }
}

class DoctorList extends StatelessWidget {
  final List<Doctor> doctors;

  DoctorList({required this.doctors});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return DoctorCard(doctor: doctors[index]);
      },
    );
  }
}

class DoctorGrid extends StatelessWidget {
  final List<Doctor> doctors;

  DoctorGrid({required this.doctors});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 0.4,
      ),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return DoctorCard(doctor: doctors[index]);
      },
    );
  }
}
