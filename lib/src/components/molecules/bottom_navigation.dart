import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  static int _currentIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (_currentIndex) {
      case 0:
        Navigator.pushNamed(this.context, '/');
        break;
      case 1:
        Navigator.pushNamed(this.context, '/scan');
        break;
      case 2:
        Navigator.pushNamed(this.context, '/history/visit');
        break;
      case 3:
        Navigator.pushNamed(this.context, '/history/passport');
        break;
      default:
        Navigator.pushNamed(this.context, '/error');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: 'Scan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Visits',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.luggage),
          label: 'Passports',
        )
      ],
      currentIndex: _currentIndex,
      selectedItemColor: Colors.green[400],
      unselectedItemColor: Colors.grey[800],
      onTap: _onItemSelected,
    );
  }
}
