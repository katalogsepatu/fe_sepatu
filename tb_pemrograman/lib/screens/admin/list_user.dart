// import 'package:flutter/material.dart';
// import 'package:tb_pemrograman/models/user_model.dart';
// import 'package:tb_pemrograman/services/api_services.dart';

// class ListUser extends StatefulWidget {
//   const ListUser({super.key});

//   @override
//   State<ListUser> createState() => _ListUserState();
// }

// class _ListUserState extends State<ListUser> {
//   final ApiServices _dataService = ApiServices();
//   List<UserModel> user = [];

//   @override
//   void initState() {
//     super.initState();
//     _dataService.getAllUser().then((value) {
//       if (mounted) {
//         setState(() {
//           user = value?.toList() ?? [];
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "SHOE CATALOG",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: Colors.orange.shade800,
//       ),
//       body: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10),
//             const Center(
//               child: Text(
//                 "List User",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: user.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 7),
//                     child: Card(
//                       elevation: 10,
//                       child: ListTile(
//                         title: Text(
//                           user[index].fullname,
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text(user[index].phonenumber),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }