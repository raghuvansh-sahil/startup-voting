import 'package:app/components/startup_card.dart';
import 'package:app/models/startup.dart';
import 'package:app/services/network_handler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Startup>?> futureStartups;
  Set<int> votedStartups = {};
  String selectedSort = 'Rating';

  bool isVotesLoaded = false;
  static const String votedKey = 'votedStartups';

  @override
  void initState() {
    super.initState();
    loadVotedStartups().then((_) {
      setState(() {
        futureStartups = NetworkHandler.getStartups();
      });
    });
  }

  Future<void> loadVotedStartups() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? votedList = prefs.getStringList(votedKey);

    setState(() {
      votedStartups = votedList?.map(int.parse).toSet() ?? {};
      isVotesLoaded = true;
    });
  }

  Future<void> saveVotedStartups() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> votedList = votedStartups
        .map((id) => id.toString())
        .toList();
    await prefs.setStringList(votedKey, votedList);
  }

  void refreshStartups() {
    setState(() {
      futureStartups = NetworkHandler.getStartups();
    });
  }

  void increaseVote(int id) {
    votedStartups.add(id);
    saveVotedStartups();
    refreshStartups();
  }

  void decreaseVote(int id) {
    votedStartups.remove(id);
    saveVotedStartups();
    refreshStartups();
  }

  @override
  Widget build(BuildContext context) {
    if (!isVotesLoaded) {
      return const Center(child: CircularProgressIndicator());
    }
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: FutureBuilder<List<Startup>?>(
        future: futureStartups,
        builder: (context, AsyncSnapshot<List<Startup>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData && snapshot.data != null) {
            final startups = snapshot.data!;

            if (selectedSort == 'Votes') {
              startups.sort((a, b) => b.voteCount.compareTo(a.voteCount));
            } else if (selectedSort == 'Rating') {
              startups.sort((a, b) => b.rating.compareTo(a.rating));
            }

            if (startups.isEmpty) {
              return const Center(child: Text('No startup ideas addded.'));
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Sort by: '),
                      DropdownButton<String>(
                        value: selectedSort,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedSort = newValue;
                            });
                          }
                        },
                        items: <String>['Votes', 'Rating']
                            .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            })
                            .toList(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: startups.length,
                    itemBuilder: (context, index) {
                      return StartupCard(
                        startup: startups[index],
                        voted: votedStartups.contains(startups[index].id),
                        increaseVote: () {
                          increaseVote(startups[index].id);
                        },
                        decreaseVote: () {
                          decreaseVote(startups[index].id);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Nothing to show.'));
          }
        },
      ),
    );
  }
}
