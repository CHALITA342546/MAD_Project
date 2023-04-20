import 'package:flutter/material.dart';
import 'package:mutu/Pages/chat.dart';
import 'package:mutu/Pages/userprofile.dart';
import 'package:mutu/Pages/sale.dart';
import 'package:mutu/Pages/welcome.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ProfileInformation extends StatefulWidget {
  final _pages = const [Welcome(), Sale(), Chat(), Profile()];

  const ProfileInformation({Key? key}) : super(key: key);

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  final items = const [
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.shopping_cart,
      size: 30,
    ),
    Icon(
      Icons.chat_bubble,
      size: 30,
    ),
    Icon(
      Icons.person,
      size: 30,
    )
  ];

  int index = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ProfileInformationScreen(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFB997),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Theme.of(context).primaryColor,
        items: items,
        index: index,
        color: const Color(0xFFCFB997),
        onTap: (selectIndex) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => widget._pages[selectIndex],
            ),
          );
        },
        height: 50,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        animationDuration: const Duration(milliseconds: 300),
        // animationCurve: ,
      ),
    );
  }
}

class _ProfileInformationScreen extends StatefulWidget {
  @override
  State<_ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<_ProfileInformationScreen> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCFB997),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () {},
                child: const Text("Edit Profile"),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(
                    height: 10,
                  ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      ),
                  SizedBox(
                    height: 10,
                  ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                      ),
                  
                  SizedBox(
                    height: 10,
                  ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'About',
                      ),
                      ),

                  SizedBox(
                    height: 10,
                  ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Age',
                      ),
                      ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCFB997),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('OK;'),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
