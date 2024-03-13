import 'package:flutter/material.dart';
import 'package:plo/common/widgets/custom_app_bar.dart';
import 'package:plo/views/post_write/post_write_screen/post_write_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    List<Widget> body = [
      const Icon(Icons.home),
      const Icon(Icons.search),
      FloatingActionButton(onPressed: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CreateEditPostScreen()));
      }),
      const Icon(Icons.person_4_rounded)
    ];
    return Scaffold(
      appBar: const BackButtonAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: body[currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
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
