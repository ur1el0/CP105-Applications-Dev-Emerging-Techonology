// Flutter Portfolio App with Authentication and Pink Theme + Profile, Bio, Skills, Contact

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink[50],
      ),
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  void toggleView() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) {
    return isLogin ? LoginPage(onToggle: toggleView) : RegisterPage(onToggle: toggleView);
  }
}

class LoginPage extends StatelessWidget {
  final VoidCallback onToggle;

  LoginPage({required this.onToggle});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
              TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                child: Text("Login"),
              ),
              TextButton(onPressed: onToggle, child: Text("Don't have an account? Register"))
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  final VoidCallback onToggle;

  RegisterPage({required this.onToggle});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Register", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
              TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                child: Text("Register"),
              ),
              TextButton(onPressed: onToggle, child: Text("Already have an account? Login"))
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, Object>> pages = [
    {'title': 'Profile', 'widget': ProfilePage()},
    {'title': 'Bio', 'widget': BioPage()},
    {'title': 'Skills', 'widget': SkillsPage()},
    {'title': 'Contact', 'widget': ContactPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Portfolio"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AuthPage()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.pink),
              child: Center(
                child: Text('Menu', style: TextStyle(fontSize: 24, color: Colors.white)),
              ),
            ),
            ...pages.map((p) {
              return ListTile(
                title: Text(p['title'] as String),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => p['widget'] as Widget));
                },
              );
            }).toList(),
          ],
        ),
      ),
      body: Center(child: Text("Welcome to your portfolio!", style: TextStyle(fontSize: 24))),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Your Name';

  void _editName() async {
    final controller = TextEditingController(text: name);
    final newName = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Name'),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, controller.text), child: Text('Save')),
        ],
      ),
    );
    if (newName != null && newName.isNotEmpty) {
      setState(() {
        name = newName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            SizedBox(height: 20),
            Text(name, style: TextStyle(fontSize: 22)),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _editName,
              icon: Icon(Icons.edit),
              label: Text('Edit Name'),
            ),
          ],
        ),
      ),
    );
  }
}

class BioPage extends StatefulWidget {
  @override
  State<BioPage> createState() => _BioPageState();
}

class _BioPageState extends State<BioPage> {
  String bio = 'I am a Flutter developer with a passion for clean UI and performance.';

  void _editBio() async {
    final controller = TextEditingController(text: bio);
    final newBio = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Bio'),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, controller.text), child: Text('Save')),
        ],
      ),
    );
    if (newBio != null && newBio.isNotEmpty) {
      setState(() {
        bio = newBio;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bio')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(bio, style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _editBio,
              icon: Icon(Icons.edit),
              label: Text('Edit Bio'),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillsPage extends StatefulWidget {
  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  List<String> skills = ['Flutter', 'Dart'];

  void _editSkill(int index) async {
    final result = await _showInputDialog('Edit Skill', skills[index]);
    if (result != null) {
      setState(() {
        skills[index] = result;
      });
    }
  }

  void _deleteSkill(int index) {
    setState(() {
      skills.removeAt(index);
    });
  }

  void _addSkill() async {
    final newSkill = await _showInputDialog('New Skill', '');
    if (newSkill != null && newSkill.isNotEmpty) {
      setState(() {
        skills.add(newSkill);
      });
    }
  }

  Future<String?> _showInputDialog(String title, String initialValue) {
    final controller = TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, controller.text), child: Text('Save')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Skills')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ElevatedButton.icon(
              onPressed: _addSkill,
              icon: Icon(Icons.add),
              label: Text('Add Skill'),
            ),
            SizedBox(height: 10),
            ...skills.asMap().entries.map((entry) {
              int i = entry.key;
              String skill = entry.value;
              return Card(
                child: ListTile(
                  title: Text(skill),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () => _editSkill(i)),
                      IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteSkill(i)),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Map<String, String>> contacts = [
    {'label': 'Email', 'value': 'you@example.com'},
    {'label': 'Phone', 'value': '+123456789'},
  ];

  void _editContact(int index) async {
    final result = await _showInputDialog('Edit ${contacts[index]['label']}', contacts[index]['value']!);
    if (result != null) {
      setState(() {
        contacts[index]['value'] = result;
      });
    }
  }

  void _deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  void _addContact() async {
    final label = await _showInputDialog('New Label', '');
    if (label != null && label.isNotEmpty) {
      final value = await _showInputDialog('Enter value for $label', '');
      if (value != null) {
        setState(() {
          contacts.add({'label': label, 'value': value});
        });
      }
    }
  }

  Future<String?> _showInputDialog(String title, String initialValue) {
    final controller = TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, controller.text), child: Text('Save')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Info')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ElevatedButton.icon(
              onPressed: _addContact,
              icon: Icon(Icons.add),
              label: Text('Add Contact'),
            ),
            SizedBox(height: 10),
            ...contacts.asMap().entries.map((entry) {
              int i = entry.key;
              var item = entry.value;
              return Card(
                child: ListTile(
                  title: Text('${item['label']}: ${item['value']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () => _editContact(i)),
                      IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteContact(i)),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
