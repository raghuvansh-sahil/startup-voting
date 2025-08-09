import 'package:app/models/startup.dart';
import 'package:app/models/vote_update_request.dart';
import 'package:app/services/network_handler.dart';
import 'package:flutter/material.dart';

class StartupCard extends StatefulWidget {
  final Startup startup;
  final bool voted;
  final Function() increaseVote;
  final Function() decreaseVote;

  const StartupCard({
    super.key,
    required this.startup,
    required this.voted,
    required this.increaseVote,
    required this.decreaseVote,
  });

  @override
  State<StartupCard> createState() => _StartupCardState();
}

class _StartupCardState extends State<StartupCard> {
  bool showFull = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.startup.startupName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "\"${widget.startup.tagline}\"",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.startup.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (showFull) ...[
              Divider(thickness: 1),
              Text(
                widget.startup.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
            ],
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    await NetworkHandler.updateVotes(
                      widget.voted
                          ? VoteUpdateRequest(
                              id: widget.startup.id,
                              voteChange: -1,
                            )
                          : VoteUpdateRequest(
                              id: widget.startup.id,
                              voteChange: 1,
                            ),
                    );
                    widget.voted
                        ? widget.decreaseVote()
                        : widget.increaseVote();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: widget.voted ? Colors.green : Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.startup.voteCount} votes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.voted ? Colors.green : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showFull = !showFull;
                    });
                  },
                  child: Text(showFull ? 'Read less' : 'Read more...'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
