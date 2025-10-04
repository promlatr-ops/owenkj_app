import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Card'),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 102, 190, 234),
                    Color.fromARGB(255, 75, 129, 162),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Profile Picture
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          "https://scontent.fbkk12-2.fna.fbcdn.net/v/t39.30808-6/494312356_9707126796042007_8197133966312264844_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeEMOToBnsEnU7jhfwaVhP6_B0ZUm2Kn8NUHRlSbYqfw1bBV-pplV1LMAKl4mVbl0-Vpt0D5dG9xtaRSwGy3eX2y&_nc_ohc=KPjrHTNozZIQ7kNvwEOiUj_&_nc_oc=Adkcv-y_Im5lrzh8x-2mApuiZiQUF_9294RrXESLgW_TcT8KMhGeJ-JhcnC6DwMTQ60&_nc_zt=23&_nc_ht=scontent.fbkk12-2.fna&_nc_gid=lAb7RkYkJrTJ2us5SNDsGQ&oh=00_AfU9pebClOfeSdAw4e06JvcQCjLLkQ9ydbhpONLoXhbAJA&oe=68AF0B72",
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Name
                  const Text(
                    'Rapeepat Promlat aka Owen KJ',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Bio
                  const Text(
                    'Male, Backend Developer and support Man City',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatColumn('StdNum', '660710184'),
                      _buildStatColumn('Major', 'Data Science'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          // Open URL cross-platform using url_launcher
                          launchUrlString('https://github.com/owenkujo');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Image.network(
                          'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
                          width: 24,
                          height: 24,
                        ),
                      )),
                      Expanded(
                          child: IconButton(
                        onPressed: () {
                          launchUrlString('https://www.facebook.com/owen.rapeepat.2025/');
                        },
                        icon: const Icon(Icons.facebook),
                        color: Colors.white,
                        iconSize: 30,
                      )),
                      Expanded(
                          child: IconButton(
                        onPressed: () {
                          launchUrlString('https://discord.gg/45uKCm49U9');
                        }
                        icon: const Icon(Icons.discord),
                        color: Colors.white,
                        iconSize: 30,
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
