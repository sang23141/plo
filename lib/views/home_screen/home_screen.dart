import 'package:email_vertify/views/post_write/post_write_screen/post_write_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    List<Widget> body =  [
      Icon(Icons.home),
      Icon(Icons.search),
      FloatingActionButton(onPressed: () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateEditPostScreen()));
      } ),
      Icon(Icons.person_4_rounded)
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: body[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.post_add),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.person_4_rounded),
          ),
        ],
      ),
    );
  }
}
