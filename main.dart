import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAmfIj82eOR_ZnW4ZY0A5xTb2Qm20WLG1A",
      appId: "1:10810633722:android:d12d22de372827984d4843",
      messagingSenderId: "10810633722	",
      projectId: "todo-13b04",
    ),
  );
  runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => TodoListHomePage(),
        '/settings': (context) => SettingsPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}

class TodoListHomePage extends StatefulWidget {
  @override
  _TodoListHomePageState createState() => _TodoListHomePageState();
}

class _TodoListHomePageState extends State<TodoListHomePage> {
  final List<String> _todoItems = [
    'Buy groceries',
    'Finish homework',
    'Call mom',
    'Go for a run',
    'Read a book',
  ];

  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.playlist_add_check,
              size: 50,
              color: Colors.green,
            ),
            Image.asset(
              'assets/todo_image.jpg',
              width: 200,
              height: 200,
            ),
            Text(
              'Your Todo List',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _todoItems.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(_todoItems[index]),
                    onDismissed: (direction) {
                      setState(() {
                        _todoItems.removeAt(index);
                      });
                    },
                    child: TodoItemWidget(
                      todoItem: _todoItems[index],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Enter a new todo',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_textController.text.isNotEmpty) {
                          _todoItems.add(_textController.text);
                          _textController.clear();
                        }
                      });
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class TodoItemWidget extends StatelessWidget {
  final String todoItem;

  TodoItemWidget({required this.todoItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todoItem),
      leading: Icon(Icons.check_circle_outline),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FeedbackForm(),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Text(
          "Welcome to the Todo List app! \n \n This app is designed to help you organize your tasks efficiently and stay productive throughout your day.\n Contact Us: If you have any questions, feedback, or suggestions for improvement ",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _feedbackController,
            decoration: InputDecoration(
              labelText: 'Tell us how can we improve',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your feedback';
              }
              return null;
            },
            maxLines: 3,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Implement form submission logic here
                // For now, just display a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Feedback submitted successfully!'),
                  ),
                );
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }
}