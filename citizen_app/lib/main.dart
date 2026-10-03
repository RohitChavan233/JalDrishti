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
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
          elevation: 0,
        )
      ),
      home: const CitizenDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// -----------------------------------------------------------------------------
// MODELS
// -----------------------------------------------------------------------------
class Ticket {
  final String id;
  final String issue;
  String status; // 'Reported', 'Assigned', 'Resolved', 'Closed'
  
  Ticket({required this.id, required this.issue, required this.status});
}

// -----------------------------------------------------------------------------
// 1. DASHBOARD SCREEN
// -----------------------------------------------------------------------------
class CitizenDashboard extends StatefulWidget {
  const CitizenDashboard({super.key});

  @override
  State<CitizenDashboard> createState() => _CitizenDashboardState();
}

class _CitizenDashboardState extends State<CitizenDashboard> {
  String _supplyStatus = "No supply"; // Mock initial status
  List<Ticket> _myTickets = [];

  void _addNewTicket(String issue) {
    setState(() {
      _myTickets.insert(0, Ticket(
        id: "TKT-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}", 
        issue: issue, 
        status: 'Reported'
      ));
    });
    
    // Mock backend update simulation
    Future.delayed(const Duration(seconds: 3), () {
      if(mounted && _myTickets.isNotEmpty) {
        setState(() {
          _myTickets[0].status = 'Assigned';
        });
      }
    });
    
    Future.delayed(const Duration(seconds: 8), () {
      if(mounted && _myTickets.isNotEmpty) {
        setState(() {
          _myTickets[0].status = 'Resolved';
          _supplyStatus = "Water supplied today"; // Assume it got fixed
        });
      }
    });
  }

  void _confirmResolution(int index, bool isResolved) {
    setState(() {
      if (isResolved) {
        _myTickets[index].status = 'Closed';
      } else {
        _myTickets[index].status = 'Assigned'; // Reopen
        _supplyStatus = "No supply";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasWater = _supplyStatus == "Water supplied today";

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('JalDrishti - My Tap', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ONE SIMPLE CARD
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              decoration: BoxDecoration(
                color: hasWater ? Colors.green[50] : Colors.red[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: hasWater ? Colors.green[200]! : Colors.red[200]!, width: 2),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    hasWater ? Icons.water_drop : Icons.water_drop_outlined, 
                    size: 64, 
                    color: hasWater ? Colors.green[700] : Colors.red[700]
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _supplyStatus,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: hasWater ? Colors.green[900] : Colors.red[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // REPORT PROBLEM BUTTON
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportProblemScreen()),
                );
                if (result != null && result is String) {
                  _addNewTicket(result);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.report_problem, size: 24),
                  SizedBox(width: 12),
                  Text('Report Problem', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // TICKETS SECTION
            if (_myTickets.isNotEmpty) ...[
              const Text('My Reports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: _myTickets.length,
                  itemBuilder: (context, index) {
                    final ticket = _myTickets[index];
                    return _buildTicketCard(ticket, index);
                  },
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildTicketCard(Ticket ticket, int index) {
    Color statusColor;
    switch (ticket.status) {
      case 'Reported': statusColor = Colors.orange; break;
      case 'Assigned': statusColor = Colors.blue; break;
      case 'Resolved': statusColor = Colors.green; break;
      default: statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(ticket.id, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: Text(ticket.status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
                )
              ],
            ),
            const SizedBox(height: 12),
            Text(ticket.issue, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            
            // CONFIRMATION UI IF RESOLVED
            if (ticket.status == 'Resolved') ...[
              const Divider(height: 24),
              const Text("Is water coming now?", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _confirmResolution(index, true),
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.green, side: const BorderSide(color: Colors.green)),
                      child: const Text('Yes, it is fixed'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _confirmResolution(index, false),
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
                      child: const Text('No, still dry'),
                    ),
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2. REPORT PROBLEM SCREEN
// -----------------------------------------------------------------------------
class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  String _selectedIssue = "No water";
  bool _photoAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(title: const Text("Report Issue")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("What is the problem?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            // ISSUE CHIPS
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChip("No water"),
                _buildChip("Low pressure"),
                _buildChip("Dirty water"),
                _buildChip("Leakage / Broken Pipe"),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // PHOTO BUTTON
            InkWell(
              onTap: () {
                setState(() => _photoAdded = !_photoAdded);
              },
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _photoAdded 
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(color: Colors.blue[100], child: const Icon(Icons.image, size: 64, color: Colors.blue)),
                        ),
                        const Positioned(
                          right: 8, top: 8,
                          child: CircleAvatar(backgroundColor: Colors.green, radius: 12, child: Icon(Icons.check, size: 16, color: Colors.white)),
                        )
                      ],
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text("Tap to add a photo (Optional)", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // AUTO LOCATION
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.green[600], size: 20),
                const SizedBox(width: 8),
                Text("Location automatically attached", style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w500)),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.cloud_off, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Text("Works offline (Syncs when connected)", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
            
            const Spacer(),
            
            // SUBMIT
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedIssue);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Submit Report', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    bool isSelected = _selectedIssue == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        if (selected) setState(() => _selectedIssue = label);
      },
      selectedColor: const Color(0xFF0D47A1).withOpacity(0.1),
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF0D47A1) : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(color: isSelected ? const Color(0xFF0D47A1) : Colors.grey[300]!),
    );
  }
}
