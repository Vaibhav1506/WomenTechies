// import 'package:flutter/material.dart';
// import 'user.dart';
// import 'driver.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Simple Flutter App',
//       theme: ThemeData(primarySwatch: const Color.fromARGB(255, 29, 25, 39)),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Welcome to AutoWala'),centerTitle: true,), 
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => UserLoginPage()),
//                 );
//               },
//               child: Text('User Login'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => DriverLoginPage()),
//                 );
//               },
//               child: Text('Driver Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:project/driver.dart';
import 'Functionalities/location_detector.dart';
import 'Functionalities/saving_userID.dart';
import 'package:project/user_main_page.dart';
import 'package:project/home_page.dart';
import 'package:project/driver_main_page.dart';
enum UserType{
  user,
  driver,
}
LocationService locationService = LocationService(); // Initialize globally

bool data_saved=false;
String? user_type='None';
void main()  async{
  //locationService.startTracking(cont:true);
  // Check permissions and start tracking
  WidgetsFlutterBinding.ensureInitialized();
  await locationService.requestLocationPermission();
  data_saved=await saveDataIfKeyDoesNotExist('id' ,'user_type');
  if(data_saved){
    user_type=await getData('user_type');
  }
  locationService.startTracking(cont: true);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (data_saved)? ((user_type=='user')?const UserMainPage():const DriverMainPage()) : const HomePage(), // Check if data is saved and navigate accordingly
      // home: UserPage(),
    );
  }
}




