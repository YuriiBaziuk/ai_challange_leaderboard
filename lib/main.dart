import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Leaderboard(),
    );
  }
}

class User {
  final String name;
  final int score;
  final bool isTopScore;

  User(this.name, this.score, this.isTopScore);
}

class Leaderboard extends StatelessWidget {
  final List<User> regionUsers = [
    User('Michael Brown', 800, Random().nextBool()),
    User('Jane Smith', 700, Random().nextBool()),
    User('Alice Johnson', 600, Random().nextBool()),
    User('Emma Davis', 650, Random().nextBool()),
    User('Sarah Thompson', 550, Random().nextBool()),
    User('David Wilson', 450, Random().nextBool()),
    User('John Doe', 400, Random().nextBool()),
    User('Bob Williams', 300, Random().nextBool()),
  ];

  final List<User> nationalUsers = [
    User('Daniel Johnson', 950, Random().nextBool()),
    User('Olivia Taylor', 830, Random().nextBool()),
    User('William Anderson', 800, Random().nextBool()),
    User('Sophia Smith', 790, Random().nextBool()),
    User('James Davis', 720, Random().nextBool()),
    User('Sophia Brown', 710, Random().nextBool()),
    User('Oliver Wilson', 680, Random().nextBool()),
    User('Emily Thompson', 600, Random().nextBool()),
  ];

  final List<User> globalUsers = [
    User('Ella Hernandez', 920, Random().nextBool()),
    User('Benjamin Moore', 860, Random().nextBool()),
    User('Alexander Lee', 820, Random().nextBool()),
    User('Mia Davis', 790, Random().nextBool()),
    User('Logan Taylor', 790, Random().nextBool()),
    User('Sofia Thomas', 730, Random().nextBool()),
    User('Jacob Wilson', 710, Random().nextBool()),
    User('Grace Thompson', 670, Random().nextBool()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leaderboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Leaderboard',
              style: TextStyle(color: Colors.black),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFDFDFDF),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: TabBar(
                    indicatorColor: Colors.blue,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black.withOpacity(0.6),
                    tabs: [
                      Tab(text: 'Region'),
                      Tab(text: 'National'),
                      Tab(text: 'Global'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              buildLeaderboard(context, regionUsers), // Region
              buildLeaderboard(context, nationalUsers), // National
              buildLeaderboard(context, globalUsers), // Global
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLeaderboard(BuildContext context, List<User> users) {
    return Column(
      children: [
        Expanded(
          child: CustomWidget([users[0], users[1], users[2]]),
        ), // Display first 3 users
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFDFDFDF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: ListView.builder(
              itemCount: users.length - 3,
              itemBuilder: (context, index) {
                User user = users[index + 3];
                Color triangleColor = user.isTopScore ? Colors.green : Colors.red;
                IconData triangleIcon =
                    user.isTopScore ? Icons.arrow_drop_up : Icons.arrow_drop_down;

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(user.name[0]),
                  ),
                  title: Text(user.name),
                  subtitle: Text('@${user.name}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Score: ${user.score}'),
                      Icon(
                        triangleIcon,
                        color: triangleColor,
                        size: 30.0,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CustomWidget extends StatelessWidget {
  final List<User> users;

  const CustomWidget(this.users);

  @override
  Widget build(BuildContext context) {
    users.sort((a, b) => b.score.compareTo(a.score));

    final user1 = users[0]; // User with the maximum score
    final user2 = users[1]; // User on the left
    final user3 = users[2]; // User on the right

    return Container(
      height: 120,
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildUserColumn(user2), // User on the left
          buildUserColumn(user1), // User in the center
          buildUserColumn(user3), // User on the right
        ],
      ),
    );
  }

  Column buildUserColumn(User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          // Replace with user picture
          child: Text(
            user.name[0],
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          user.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Score: ${user.score}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '@${user.name}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
