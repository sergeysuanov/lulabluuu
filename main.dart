import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Buddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false, // Убираем ярлык DEBUG
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    
    String username = _usernameController.text;
    String password = _passwordController.text;


    print('Username: $username');
    print('Password: $password');

   
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> trips = [
    {"title": "Trip 1", "description": "Description for Trip 1", "image": "assets/images/trip1.jpg"},
    {"title": "Trip 2", "description": "Description for Trip 2", "image": "assets/images/trip2.jpg"},
    {"title": "Trip 3", "description": "Description for Trip 3", "image": "assets/images/trip3.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Buddy'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
            
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateTripScreen()),
              );
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Друзья'),
                value: 'friends',
              ),
              PopupMenuItem(
                child: Text('Избранное'),
                value: 'favorites',
              ),
              PopupMenuItem(
                child: Text('Поездки'),
                value: 'trips',
              ),
            ],
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          HomeGridItem(
            title: 'Друзья',
            icon: Icons.group,
            onPressed: () {
           
              print('Pressed Friends');
            },
          ),
          HomeGridItem(
            title: 'Избранное',
            icon: Icons.star,
            onPressed: () {
             
              print('Pressed Favorites');
            },
          ),
          HomeGridItem(
            title: 'Поездки',
            icon: Icons.directions_car,
            onPressed: () {
              
              print('Pressed Trips');
            },
          ),
        ],
      ),
    );
  }
}

class CreateTripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Trip'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: TripForm(),
      ),
    );
  }
}

class TripForm extends StatefulWidget {
  @override
  _TripFormState createState() => _TripFormState();
}

class _TripFormState extends State<TripForm> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _passengersController = TextEditingController();
  final TextEditingController _vehicleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          controller: _fromController,
          decoration: InputDecoration(labelText: 'Откуда'),
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: _toController,
          decoration: InputDecoration(labelText: 'Куда'),
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: _passengersController,
          decoration: InputDecoration(labelText: 'Сколько попутчиков'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: _vehicleController,
          decoration: InputDecoration(labelText: 'На чем'),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            
            String from = _fromController.text;
            String to = _toController.text;
            int passengers = int.tryParse(_passengersController.text) ?? 0;
            String vehicle = _vehicleController.text;

          
            print('From: $from');
            print('To: $to');
            print('Passengers: $passengers');
            print('Vehicle: $vehicle');

           
            Navigator.pop(context);
          },
          child: Text('Создать поездку'),
        ),
      ],
    );
  }
}

class HomeGridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const HomeGridItem({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 50,
                color: Colors.blue,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
