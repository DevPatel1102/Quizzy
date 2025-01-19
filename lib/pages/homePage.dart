import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePage();
}

class _homePage extends State<homePage> {
  int previous_score = 0;

  @override
  void initState() {
    super.initState();
  }

  // Function to load the saved score from SharedPreferences
  Future<void> _loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      previous_score = prefs.getInt('previous_score') ?? 0; // Default to 0 if no score is saved
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadScore();
    String title = "Genetics and Evolution";
    String topic = "The Molecular Basis of Inheritance";

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 35, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Hello, User\n",
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "Glad To See You Again",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Image.asset('assets/user_icon.png', height: 90, width: 90),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 280,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF8E2DE2),
                    Color(0xFF4A00E0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "Previous Score : $previous_score",
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 70),
            Text(
              "Title : $title",
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 9,
                ),
                children: [
                  _buildDashboardCard(topic, () {
                    Navigator.pushNamed(context, '/quiz_screen');
                  }),
                  _buildDashboardCard('?', () {
                    const snackBar = SnackBar(
                      content: Text("In future more topics would be added"),
                      duration: Duration(seconds: 1),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }),
                  _buildDashboardCard('?', () {
                    const snackBar = SnackBar(
                      content: Text("In future more topics would be added"),
                      duration: Duration(seconds: 1),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }),
                  _buildDashboardCard('?', () {
                    const snackBar = SnackBar(
                      content: Text("In future more topics would be added"),
                      duration: Duration(seconds: 1),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 280,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF934ecc)),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFAD73DF),
              Color(0xFF5B1AE1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(  
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
