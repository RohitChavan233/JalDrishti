import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark)
  );
  runApp(const JalDrishtiApp());
}

class JalDrishtiApp extends StatelessWidget {
  const JalDrishtiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JalDrishti',
      theme: ThemeData(
        primaryColor: const Color(0xFF007D8C), // Premium Teal
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF007D8C)),
        useMaterial3: true,
        fontFamily: 'Inter', // Assuming Inter is default or added
        scaffoldBackgroundColor: const Color(0xFFF7FAFC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF1A202C)),
          titleTextStyle: TextStyle(color: Color(0xFF1A202C), fontSize: 20, fontWeight: FontWeight.w700),
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
  String status; 
  final String timestamp;
  
  Ticket({required this.id, required this.issue, required this.status, required this.timestamp});

  Map<String, dynamic> toJson() => {
    'id': id,
    'issue': issue,
    'status': status,
    'timestamp': timestamp,
  };

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json['id'],
    issue: json['issue'],
    status: json['status'],
    timestamp: json['timestamp'] ?? DateTime.now().toIso8601String(),
  );
}

// -----------------------------------------------------------------------------
// 1. DASHBOARD SCREEN
// -----------------------------------------------------------------------------
class CitizenDashboard extends StatefulWidget {
  const CitizenDashboard({super.key});

  @override
  State<CitizenDashboard> createState() => _CitizenDashboardState();
}

class _CitizenDashboardState extends State<CitizenDashboard> with SingleTickerProviderStateMixin {
  String _supplyStatus = "No supply"; 
  List<Ticket> _myTickets = [];
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic);
    _animController.forward();
    _loadTickets();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _loadTickets() async {
    final prefs = await SharedPreferences.getInstance();
    final ticketsJson = prefs.getStringList('myTickets');
    if (ticketsJson != null) {
      setState(() {
        _myTickets = ticketsJson.map((t) => Ticket.fromJson(jsonDecode(t))).toList();
      });
    }
  }

  Future<void> _saveTickets() async {
    final prefs = await SharedPreferences.getInstance();
    final ticketsJson = _myTickets.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList('myTickets', ticketsJson);
  }

  Future<void> _addNewTicket(String issue) async {
    final ticketId = "TKT-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
    
    setState(() {
      _myTickets.insert(0, Ticket(
        id: ticketId, 
        issue: issue, 
        status: 'Reported',
        timestamp: DateTime.now().toIso8601String()
      ));
    });
    
    await _saveTickets();

    try {
      await http.post(
        Uri.parse('http://10.22.234.32:3000/api/tickets'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': ticketId,
          'issue': issue,
          'details': 'Citizen App Report • Location auto-detected'
        }),
      );
    } catch (e) {
      debugPrint("Failed to sync with server: $e");
    }
    
    // Mock backend update simulation
    Future.delayed(const Duration(seconds: 4), () {
      if(mounted && _myTickets.isNotEmpty) {
        setState(() {
          _myTickets[0].status = 'Assigned';
        });
        _saveTickets();
      }
    });
    
    Future.delayed(const Duration(seconds: 10), () {
      if(mounted && _myTickets.isNotEmpty) {
        setState(() {
          _myTickets[0].status = 'Resolved';
          _supplyStatus = "Water supplied today";
        });
        _saveTickets();
      }
    });
  }

  void _confirmResolution(int index, bool isResolved) {
    setState(() {
      if (isResolved) {
        _myTickets[index].status = 'Closed';
      } else {
        _myTickets[index].status = 'Assigned'; 
        _supplyStatus = "No supply";
      }
    });
    _saveTickets();
  }

  @override
  Widget build(BuildContext context) {
    bool hasWater = _supplyStatus == "Water supplied today";

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF007D8C),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.water_drop, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            const Text('JalDrishti', style: TextStyle(letterSpacing: -0.5)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF4A5568)),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          color: const Color(0xFF007D8C),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              // Greeting
              const Text("Hello, Villager", style: TextStyle(fontSize: 16, color: Color(0xFF718096), fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              const Text("Gram Panchayat Bhor", style: TextStyle(fontSize: 24, color: Color(0xFF1A202C), fontWeight: FontWeight.w800, letterSpacing: -0.5)),
              const SizedBox(height: 24),
              
              // Status Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: hasWater 
                      ? [const Color(0xFF2F855A), const Color(0xFF48BB78)] 
                      : [const Color(0xFFC53030), const Color(0xFFF56565)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: (hasWater ? const Color(0xFF48BB78) : const Color(0xFFF56565)).withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        hasWater ? Icons.water_drop : Icons.water_drop_outlined, 
                        size: 48, 
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _supplyStatus,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      hasWater ? "Your connection is fully functional" : "Water supply interrupted in your area",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Report Button
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const ReportProblemScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.easeOutQuart;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        return SlideTransition(position: animation.drive(tween), child: child);
                      },
                    ),
                  );
                  if (result != null && result is String) {
                    _addNewTicket(result);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFC53030),
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  elevation: 0,
                  side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.support_agent, size: 20, color: Color(0xFFC53030)),
                    ),
                    const SizedBox(width: 12),
                    const Text('Report a Problem', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF2D3748))),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              if (_myTickets.isNotEmpty) ...[
                const Row(
                  children: [
                    Text('Recent Reports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1A202C), letterSpacing: -0.5)),
                    Spacer(),
                    Text('See all', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF007D8C))),
                  ],
                ),
                const SizedBox(height: 16),
                ...List.generate(_myTickets.length, (index) => _buildTicketCard(_myTickets[index], index))
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketCard(Ticket ticket, int index) {
    Color statusColor;
    Color statusBg;
    switch (ticket.status) {
      case 'Reported': statusColor = const Color(0xFFDD6B20); statusBg = const Color(0xFFFEEBC8); break;
      case 'Assigned': statusColor = const Color(0xFF3182CE); statusBg = const Color(0xFFEBF8FF); break;
      case 'Resolved': statusColor = const Color(0xFF38A169); statusBg = const Color(0xFFF0FFF4); break;
      case 'Closed': statusColor = const Color(0xFF718096); statusBg = const Color(0xFFEDF2F7); break;
      default: statusColor = Colors.grey; statusBg = Colors.grey[200]!;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 2)),
        ],
        border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.receipt_long, size: 16, color: Color(0xFFA0AEC0)),
                    const SizedBox(width: 6),
                    Text(ticket.id, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF718096), fontSize: 13)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(20)),
                  child: Text(ticket.status, style: TextStyle(color: statusColor, fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 0.2)),
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(ticket.issue, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF2D3748))),
            
            if (ticket.status == 'Resolved') ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.check_circle, size: 18, color: Color(0xFF38A169)),
                        SizedBox(width: 8),
                        Text("Engineer marked as fixed", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF2D3748))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text("Is water coming now?", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color(0xFF718096))),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _confirmResolution(index, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF38A169),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Yes', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _confirmResolution(index, false),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFE53E3E), 
                              side: const BorderSide(color: Color(0xFFFEB2B2)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('No, still dry', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      }
    } catch (e) {
      try {
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          setState(() {
            _image = File(image.path);
          });
        }
      } catch (e) {
        debugPrint("Image picker failed: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Report Issue"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("What seems to be the problem?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1A202C), letterSpacing: -0.5, height: 1.2)),
              const SizedBox(height: 8),
              const Text("Select the category that best describes the issue.", style: TextStyle(fontSize: 14, color: Color(0xFF718096))),
              const SizedBox(height: 24),
              
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildChip("No water", Icons.water_drop_outlined),
                  _buildChip("Low pressure", Icons.speed),
                  _buildChip("Dirty water", Icons.coronavirus_outlined),
                  _buildChip("Broken Pipe", Icons.plumbing),
                  _buildChip("Other", Icons.more_horiz),
                ],
              ),
              
              const SizedBox(height: 36),
              const Text("Attach Photo (Optional)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF2D3748))),
              const SizedBox(height: 12),
              
              InkWell(
                onTap: _pickImage,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7FAFC),
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _image != null 
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(_image!, fit: BoxFit.cover),
                          ),
                          Positioned(
                            right: 12, top: 12,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(color: Color(0xFF38A169), shape: BoxShape.circle),
                              child: const Icon(Icons.check, size: 16, color: Colors.white),
                            ),
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                            child: const Icon(Icons.camera_alt, size: 24, color: Color(0xFF007D8C)),
                          ),
                          const SizedBox(height: 12),
                          const Text("Tap to take a photo", style: TextStyle(color: Color(0xFF718096), fontWeight: FontWeight.w500, fontSize: 14)),
                        ],
                      ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FFF4),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFC6F6D5)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.location_on, color: Color(0xFF38A169), size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text("Location automatically attached for faster resolution", style: TextStyle(color: Color(0xFF276749), fontWeight: FontWeight.w500, fontSize: 13, height: 1.4)),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _selectedIssue);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007D8C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Submit Report', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, IconData iconData) {
    bool isSelected = _selectedIssue == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedIssue = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF007D8C) : Colors.white,
          border: Border.all(color: isSelected ? const Color(0xFF007D8C) : const Color(0xFFE2E8F0), width: 1.5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF007D8C).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, size: 18, color: isSelected ? Colors.white : const Color(0xFF718096)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF2D3748),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 14
              ),
            ),
          ],
        ),
      ),
    );
  }
}
