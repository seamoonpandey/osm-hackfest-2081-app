import 'package:community_connect/data/dummy_users.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index) {
        final user = userList[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: index == 0
                ? Colors.amber
                : index == 1
                    ? Colors.grey
                    : index == 2
                        ? Colors.brown
                        : Colors.blueGrey,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          title: Text(
            user.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('@${user.username}'),
        );
      },
    );
  }
}
