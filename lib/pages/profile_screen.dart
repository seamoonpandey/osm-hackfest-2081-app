import 'package:community_connect/pages/auth/login.dart';
import 'package:community_connect/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int hosted = 0;
  int attended = 0;
  int participated = 0;
  String name = '';

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hosted = prefs.getInt('stats_hosted') ?? 0; // Default to 0 if not set
      attended = prefs.getInt('stats_attended') ?? 0; // Default to 0 if not set
      participated =
          prefs.getInt('stats_participated') ?? 0; // Default to 0 if not set
      name = prefs.getString('user_name') ?? ''; // Default to '' if not set
    });
  }

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all data from SharedPreferences
    setState(() {
      hosted = 0;
      attended = 0;
      participated = 0;
      name = '';
    });

    // Navigate to a login or splash screen and clear the stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String username = name.split(' ')[0].toLowerCase();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: HeaderCurvedContainer(),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            '@$username',
                            style: const TextStyle(
                                fontSize: 35,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: const DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage("assets/ZARA.jpg"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff555555))),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.red),
                    onPressed: _logout,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Chip(
                        label: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Hosted',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            Text('$hosted'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Chip(
                        label: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Attended',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            Text('$attended'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Chip(
                        label: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Participated',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            Text('$participated'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const SizedBox(
                  height: 420, // Or any appropriate height
                  child: MapWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff555555);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
