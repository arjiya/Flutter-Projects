// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../cubit/auth_cubit.dart';
// import 'login_screen.dart';


// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String userEmail = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserEmail();
//   }

//   // Load saved email from SharedPreferences
//   Future<void> _loadUserEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     final email = prefs.getString('savedEmail') ?? '';
//     setState(() {
//       userEmail = email;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dashboard"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               context.read<AuthCubit>().logout();
//               Navigator.pushReplacementNamed(context, '/login');
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 20),
//           Text(
//             'Welcome, $userEmail',
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),
//           Expanded(
//             child: GridView.count(
//               crossAxisCount: 4,
//               padding: const EdgeInsets.all(5),
//               children: const [
//                 _HomeTile(icon: Icons.home, label: "Home"),
//                 _HomeTile(icon: Icons.notifications, label: "Notification"),
//                 _HomeTile(icon: Icons.person, label: "Profile"),
//                 _HomeTile(icon: Icons.settings, label: "Setting"),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _HomeTile extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   const _HomeTile({required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 30),
//           const SizedBox(height: 10),
//           Text(label),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/auth_cubit.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userEmail = '';
  List<dynamic> posts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
    _fetchPosts();
  }

  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('savedEmail') ?? '';
    setState(() {
      userEmail = email;
    });
  }

  Future<void> _fetchPosts() async {
    ApiService apiService = ApiService();
    final data = await apiService.getPosts();

    setState(() {
      posts = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthCubit>().logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            'Welcome, $userEmail',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // SHOW API RESULTS
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return ListTile(
                        title: Text(post["title"] ?? ""),
                        subtitle: Text(post["body"] ?? ""),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
