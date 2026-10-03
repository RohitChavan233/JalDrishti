import 'package:flutter/material.dart';

void main() {
  runApp(const JalDrishtiApp());
}

class JalDrishtiApp extends StatelessWidget {
  const JalDrishtiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JalDrishti',
      theme: ThemeData(
        primaryColor: const Color(0xFF0D47A1), // Deep Blue
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D47A1)),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const CitizenDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CitizenDashboard extends StatefulWidget {
  const CitizenDashboard({super.key});

  @override
  State<CitizenDashboard> createState() => _CitizenDashboardState();
}

class _CitizenDashboardState extends State<CitizenDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Tap', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              // Language switch logic
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Notifications logic
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatusCard(),
            const SizedBox(height: 16),
            _buildSupplyWindowCard(),
            const SizedBox(height: 16),
            _buildQualityBadge(),
            const SizedBox(height: 16),
            _buildReportProblemButton(),
            const SizedBox(height: 24),
            const Text(
              'Village Alerts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
            ),
            const SizedBox(height: 12),
            _buildVillageAlert(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: 'My Tap'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: const Color(0xFF0D47A1),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Current Status',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'No Supply',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Last updated: 10 mins ago',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplyWindowCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Today\'s Supply Window',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
              ),
              const SizedBox(height: 4),
              Text('Expected: 06:00 AM - 08:00 AM', style: TextStyle(color: Colors.grey[700])),
              Text('Actual: No flow detected', style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.w500)),
            ],
          ),
          const Icon(Icons.schedule, color: Color(0xFF0D47A1), size: 32),
        ],
      ),
    );
  }

  Widget _buildQualityBadge() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green[100]!),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified, color: Colors.green, size: 28),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Water Quality Safe',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
              Text('Last tested at ESR: 2 hours ago', style: TextStyle(fontSize: 12, color: Colors.green[800])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportProblemButton() {
    return ElevatedButton(
      onPressed: () {
        // Report problem navigation
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.report_problem),
          SizedBox(width: 8),
          Text('Report a Problem', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildVillageAlert() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber[200]!),
        borderSide: const BorderSide(width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.amber[800], size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pump Maintenance Ongoing',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber[900]),
                ),
                const SizedBox(height: 4),
                Text(
                  'Supply will be delayed by 2 hours. Technicians are on site fixing a pump issue.',
                  style: TextStyle(color: Colors.amber[900], fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
