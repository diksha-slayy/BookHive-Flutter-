import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String _userName = "Guest";
  String _email = "Not Available";
  String _profilePic = "https://via.placeholder.com/150";

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieving the stored user details from SharedPreferences (if they exist)
    setState(() {
      _userName = prefs.getString('user_name') ?? "Guest";
      _email = prefs.getString('user_email') ?? "Not Available";
      _profilePic = prefs.getString('user_profile_pic') ?? "https://via.placeholder.com/150";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Center(
        child: Card(
          color: Color(0xFFFFECB8),
          margin: EdgeInsets.all(20),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_profilePic),
                ),
                SizedBox(height: 10),
                Text(
                  _userName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  _email,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class UserProfileScreen extends StatelessWidget {
//   final String _userName = "John Doe";
//   final String _email = "johndoe@example.com";
//   final String _profilePic = "https://via.placeholder.com/150";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('User Profile')),
//       body: Center(
//         child: Card(
//           color: Color(0xFFFFECB8),
//           margin: EdgeInsets.all(20),
//           elevation: 8,
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(_profilePic),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   _userName,
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   _email,
//                   style: TextStyle(fontSize: 18, color: Colors.black54),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
