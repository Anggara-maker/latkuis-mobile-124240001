import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final bool showAppBar;
  final VoidCallback? onLogout;

  const ProfileScreen({
    super.key,
    required this.username,
    this.showAppBar = true,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFA),
      appBar: showAppBar
          ? AppBar(
              title: const Text(
                "Profil",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF17343A),
                ),
              ),
              backgroundColor: Colors.white,
              foregroundColor:
                  const Color(0xFF006D7A),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              if (!showAppBar)
                const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF006D7A),
                  borderRadius:
                      BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Color(0xFF006D7A),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Profil Pengguna",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      username,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.all(16),
                  leading: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color:
                          const Color(0xFFE2F5F7),
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Color(0xFF006D7A),
                    ),
                  ),
                  title: Text(
                    "Username",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                  subtitle: Padding(
                    padding:
                        const EdgeInsets.only(top: 4),
                    child: Text(
                      username,
                      style: const TextStyle(
                        color: Color(0xFF17343A),
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: onLogout,
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    "Logout",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    // Logout sengaja tetap merah
                    backgroundColor:
                        const Color(0xFFE21B23),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}