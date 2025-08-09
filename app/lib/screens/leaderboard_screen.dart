import 'package:app/components/leaderboard_card.dart';
import 'package:app/models/startup.dart';
import 'package:app/services/network_handler.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late Future<List<Startup>?> futureStartups;

  @override
  void initState() {
    super.initState();
    futureStartups = NetworkHandler.getStartups();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: FutureBuilder<List<Startup>?>(
        future: futureStartups,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData && snapshot.data != null) {
            final startups = snapshot.data!;

            final topStartups = startups
              ..sort((a, b) => b.voteCount.compareTo(a.voteCount));
            final top5 = topStartups.take(5).toList();

            if (top5.isEmpty) {
              return const Center(child: Text('No startups to show.'));
            }

            return ListView.builder(
              itemCount: top5.length,
              itemBuilder: (context, index) {
                return LeaderboardCard(startup: top5[index], rank: index);
              },
            );
          } else {
            return const Center(child: Text('Nothing to show.'));
          }
        },
      ),
    );
  }
}
