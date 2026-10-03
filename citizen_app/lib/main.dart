import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

// --- TRANSLATION SYSTEM ---
final ValueNotifier<String> appLanguage = ValueNotifier('en');

const Map<String, Map<String, String>> translations = {
  'en': {
    'app_title': 'JalDrishti',
    'hello': 'Hello, Villager',
    'village_name': 'Gram Panchayat Bhor',
    'no_supply': 'No supply',
    'water_supplied': 'Water supplied today',
    'functional': 'Your connection is fully functional',
    'interrupted': 'Water supply interrupted in your area',
    'report_btn': 'Report a Problem',
    'recent_reports': 'Recent Reports',
    'see_all': 'See all',
    'report_issue': 'Report Issue',
    'what_problem': 'What seems to be the problem?',
    'select_category': 'Select the category that best describes the issue.',
    'attach_photo': 'Attach Photo (Optional)',
    'tap_photo': 'Tap to take a photo',
    'location_auto': 'Location automatically attached for faster resolution',
    'submit_btn': 'Submit Report',
    'engineer_fixed': 'Engineer marked as fixed',
    'is_water_coming': 'Is water coming now?',
    'yes': 'Yes',
    'no': 'No, still dry',
    'status_Reported': 'Reported',
    'status_Assigned': 'Assigned',
    'status_Resolved': 'Resolved',
    'status_Closed': 'Closed',
    'issue_No water': 'No water',
    'issue_Low pressure': 'Low pressure',
    'issue_Dirty water': 'Dirty water',
    'issue_Broken Pipe': 'Broken Pipe',
    'issue_Other': 'Other',
    'lang_en': 'English',
    'lang_hi': 'हिंदी (Hindi)',
    'lang_mr': 'मराठी (Marathi)',
    'select_language': 'Select Language',
  },
  'hi': {
    'app_title': 'जलदृष्टि',
    'hello': 'नमस्ते, ग्रामवासी',
    'village_name': 'ग्राम पंचायत भोर',
    'no_supply': 'कोई आपूर्ति नहीं',
    'water_supplied': 'आज पानी की आपूर्ति',
    'functional': 'आपका कनेक्शन पूरी तरह से काम कर रहा है',
    'interrupted': 'आपके क्षेत्र में पानी की आपूर्ति बाधित है',
    'report_btn': 'समस्या दर्ज करें',
    'recent_reports': 'हालिया रिपोर्ट',
    'see_all': 'सभी देखें',
    'report_issue': 'समस्या दर्ज करें',
    'what_problem': 'क्या समस्या है?',
    'select_category': 'उस श्रेणी का चयन करें जो समस्या का सबसे अच्छा वर्णन करती है।',
    'attach_photo': 'फोटो जोड़ें (वैकल्पिक)',
    'tap_photo': 'फोटो लेने के लिए टैप करें',
    'location_auto': 'तेजी से समाधान के लिए स्थान स्वचालित रूप से संलग्न',
    'submit_btn': 'रिपोर्ट सबमिट करें',
    'engineer_fixed': 'इंजीनियर ने ठीक कर दिया',
    'is_water_coming': 'क्या अब पानी आ रहा है?',
    'yes': 'हाँ',
    'no': 'नहीं, अभी भी सूखा है',
    'status_Reported': 'दर्ज किया गया',
    'status_Assigned': 'सौंपा गया',
    'status_Resolved': 'सुलझा लिया गया',
    'status_Closed': 'बंद',
    'issue_No water': 'पानी नहीं',
    'issue_Low pressure': 'कम दबाव',
    'issue_Dirty water': 'गंदा पानी',
    'issue_Broken Pipe': 'टूटा हुआ पाइप',
    'issue_Other': 'अन्य',
    'lang_en': 'English',
    'lang_hi': 'हिंदी (Hindi)',
    'lang_mr': 'मराठी (Marathi)',
    'select_language': 'भाषा चुनें',
  },
  'mr': {
    'app_title': 'जलदृष्टी',
    'hello': 'नमस्कार, ग्रामस्थ',
    'village_name': 'ग्रामपंचायत भोर',
    'no_supply': 'पाणी पुरवठा नाही',
    'water_supplied': 'आज पाणी आले',
    'functional': 'तुमचे कनेक्शन पूर्णपणे कार्यरत आहे',
    'interrupted': 'तुमच्या भागात पाणीपुरवठा खंडित झाला आहे',
    'report_btn': 'समस्या नोंदवा',
    'recent_reports': 'अलीकडील अहवाल',
    'see_all': 'सर्व पहा',
    'report_issue': 'समस्या नोंदवा',
    'what_problem': 'काय समस्या आहे?',
    'select_category': 'समस्येचे सर्वोत्तम वर्णन करणारी श्रेणी निवडा.',
    'attach_photo': 'फोटो जोडा (पर्यायी)',
    'tap_photo': 'फोटो काढण्यासाठी टॅप करा',
    'location_auto': 'जलद निराकरणासाठी स्थान स्वयंचलितपणे जोडले गेले',
    'submit_btn': 'अहवाल सबमिट करा',
    'engineer_fixed': 'अभियंत्याने दुरुस्त केल्याचे चिन्हांकित केले',
    'is_water_coming': 'आता पाणी येत आहे का?',
    'yes': 'होय',
    'no': 'नाही, अजूनही कोरडे आहे',
    'status_Reported': 'नोंदवले',
    'status_Assigned': 'नियुक्त केले',
    'status_Resolved': 'सोडवले',
    'status_Closed': 'बंद',
    'issue_No water': 'पाणी नाही',
    'issue_Low pressure': 'कमी दाब',
    'issue_Dirty water': 'घाणेरडे पाणी',
    'issue_Broken Pipe': 'तुटलेला पाईप',
    'issue_Other': 'इतर',
    'lang_en': 'English',
    'lang_hi': 'हिंदी (Hindi)',
    'lang_mr': 'मराठी (Marathi)',
    'select_language': 'भाषा निवडा',
  }
};

String t(String key) {
  final lang = appLanguage.value;
  return translations[lang]?[key] ?? translations['en']?[key] ?? key;
}

Future<void> setLanguage(String langCode) async {
  appLanguage.value = langCode;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('app_lang', langCode);
}
// ------------------------------------------

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark)
  );
  
  final prefs = await SharedPreferences.getInstance();
  appLanguage.value = prefs.getString('app_lang') ?? 'en';

  runApp(const JalDrishtiApp());
}

class JalDrishtiApp extends StatelessWidget {
  const JalDrishtiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JalDrishti',
      theme: ThemeData(
        primaryColor: const Color(0xFF007D8C),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF007D8C)),
        useMaterial3: true,
        fontFamily: 'Inter',
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
  final String issueKey;
  String status; 
  final String timestamp;
  
  Ticket({required this.id, required this.issueKey, required this.status, required this.timestamp});

  Map<String, dynamic> toJson() => {
    'id': id,
    'issueKey': issueKey,
    'status': status,
    'timestamp': timestamp,
  };

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json['id'],
    issueKey: json['issueKey'],
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

class _CitizenDashboardState extends State<CitizenDashboard> with TickerProviderStateMixin {
  bool _hasWater = false; 
  List<Ticket> _myTickets = [];
  
  late AnimationController _pageAnimController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    // Initial Page Load Animation
    _pageAnimController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeAnim = CurvedAnimation(parent: _pageAnimController, curve: Curves.easeOutCubic);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _pageAnimController, curve: Curves.easeOutCubic));
    _pageAnimController.forward();
    
    // Continuous Pulse Animation for the status icon
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.15).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    _loadTickets();
  }

  @override
  void dispose() {
    _pageAnimController.dispose();
    _pulseController.dispose();
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

  Future<void> _addNewTicket(String issueKey) async {
    final ticketId = "TKT-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
    
    setState(() {
      _myTickets.insert(0, Ticket(
        id: ticketId, 
        issueKey: issueKey, 
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
          'issue': t('issue_$issueKey'),
          'details': 'Citizen App Report • Location auto-detected'
        }),
      );
    } catch (e) {
      debugPrint("Failed to sync with server: $e");
    }
    
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
          _hasWater = true;
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
        _hasWater = false;
      }
    });
    _saveTickets();
  }
  
  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 16),
              child: Text(t('select_language'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A202C))),
            ),
            _buildLangOption('en', 'English'),
            _buildLangOption('hi', 'हिंदी (Hindi)'),
            _buildLangOption('mr', 'मराठी (Marathi)'),
            const SizedBox(height: 16),
          ],
        ),
      )
    );
  }
  
  Widget _buildLangOption(String code, String name) {
    final isSelected = appLanguage.value == code;
    return InkWell(
      onTap: () {
        setLanguage(code);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEBF8FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? const Color(0xFF3182CE) : Colors.transparent)
        ),
        child: Row(
          children: [
            Expanded(child: Text(name, style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? const Color(0xFF2B6CB0) : const Color(0xFF4A5568)))),
            if (isSelected) const Icon(Icons.check_circle, color: Color(0xFF3182CE))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: appLanguage,
      builder: (context, lang, _) {
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
            Text(t('app_title'), style: const TextStyle(letterSpacing: -0.5)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language, color: Color(0xFF4A5568)),
            onPressed: _showLanguageSelector,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SlideTransition(
        position: _slideAnim,
        child: FadeTransition(
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
                Text(t('hello'), style: const TextStyle(fontSize: 16, color: Color(0xFF718096), fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(t('village_name'), style: const TextStyle(fontSize: 24, color: Color(0xFF1A202C), fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                const SizedBox(height: 24),
                
                // Animated Status Card
                AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _hasWater 
                        ? [const Color(0xFF2F855A), const Color(0xFF48BB78)] 
                        : [const Color(0xFFC53030), const Color(0xFFF56565)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: (_hasWater ? const Color(0xFF48BB78) : const Color(0xFFF56565)).withOpacity(0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ScaleTransition(
                        scale: _pulseAnim,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _hasWater ? Icons.water_drop : Icons.water_drop_outlined, 
                            size: 48, 
                            color: Colors.white
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(opacity: animation, child: SlideTransition(position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(animation), child: child));
                        },
                        child: Text(
                          _hasWater ? t('water_supplied') : t('no_supply'),
                          key: ValueKey<bool>(_hasWater),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.5
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          _hasWater ? t('functional') : t('interrupted'),
                          key: ValueKey<bool>(_hasWater),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Report Button with bounce effect
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.9, end: 1.0),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.elasticOut,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: ElevatedButton(
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
                        Text(t('report_btn'), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF2D3748))),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 36),

                if (_myTickets.isNotEmpty) ...[
                  Row(
                    children: [
                      Text(t('recent_reports'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1A202C), letterSpacing: -0.5)),
                      const Spacer(),
                      Text(t('see_all'), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF007D8C))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Staggered list animation
                  ...List.generate(_myTickets.length, (index) {
                    return TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 400 + (index * 100)),
                      curve: Curves.easeOutCubic,
                      builder: (context, val, child) {
                        return Transform.translate(
                          offset: Offset(0, 50 * (1 - val)),
                          child: Opacity(opacity: val, child: child),
                        );
                      },
                      child: _buildTicketCard(_myTickets[index], index),
                    );
                  })
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(20)),
                  child: Text(t('status_${ticket.status}'), style: TextStyle(color: statusColor, fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 0.2)),
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(t('issue_${ticket.issueKey}'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF2D3748))),
            
            if (ticket.status == 'Resolved') ...[
              const SizedBox(height: 16),
              // Fade in the resolution box
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 400),
                builder: (context, val, child) {
                  return Opacity(opacity: val, child: child);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.check_circle, size: 18, color: Color(0xFF38A169)),
                          const SizedBox(width: 8),
                          Text(t('engineer_fixed'), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF2D3748))),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(t('is_water_coming'), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color(0xFF718096))),
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
                              child: Text(t('yes'), style: const TextStyle(fontWeight: FontWeight.bold)),
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
                              child: Text(t('no'), style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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
  String _selectedIssueKey = "No water";
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) setState(() => _image = File(image.path));
    } catch (e) {
      try {
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) setState(() => _image = File(image.path));
      } catch (e) {
        debugPrint("Image picker failed: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: appLanguage,
      builder: (context, lang, _) {
        return Scaffold(
          backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(t('report_issue')),
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
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                builder: (context, val, child) {
                  return Transform.translate(
                    offset: Offset(0, 20 * (1 - val)),
                    child: Opacity(opacity: val, child: child),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t('what_problem'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1A202C), letterSpacing: -0.5, height: 1.2)),
                    const SizedBox(height: 8),
                    Text(t('select_category'), style: const TextStyle(fontSize: 14, color: Color(0xFF718096))),
                  ],
                ),
              ),
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
              Text(t('attach_photo'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF2D3748))),
              const SizedBox(height: 12),
              
              InkWell(
                onTap: _pickImage,
                borderRadius: BorderRadius.circular(16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 160,
                  decoration: BoxDecoration(
                    color: _image != null ? Colors.white : const Color(0xFFF7FAFC),
                    border: Border.all(color: _image != null ? const Color(0xFF38A169) : const Color(0xFFE2E8F0), width: 1.5, style: BorderStyle.solid),
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
                          Text(t('tap_photo'), style: const TextStyle(color: Color(0xFF718096), fontWeight: FontWeight.w500, fontSize: 14)),
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
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFF38A169), size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(t('location_auto'), style: const TextStyle(color: Color(0xFF276749), fontWeight: FontWeight.w500, fontSize: 13, height: 1.4)),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _selectedIssueKey);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007D8C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(t('submit_btn'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
);
}

  Widget _buildChip(String issueKey, IconData iconData) {
    bool isSelected = _selectedIssueKey == issueKey;
    return GestureDetector(
      onTap: () => setState(() => _selectedIssueKey = issueKey),
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
              t('issue_$issueKey'),
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
