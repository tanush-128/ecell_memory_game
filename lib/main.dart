import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

var cards = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6];
int current_card = 0;

class _MainAppState extends State<MainApp> {
  int state = 0;
  void toggleState(int x) {
    setState(() {
      state = x;
    });

    ;
    // int next_card = 0;
  }

  @override
  void initState() {
    // TODO: implement initState
    cards.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("background.png"))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "EVIL YOU",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 96,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'BloodyTerror',
                          letterSpacing: 10),
                    ),
                  ),
                  Center(
                      child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 32),
                    child: Text(
                        "\"Humanity's darkest deeds are woven from the threads of its own desires, a tapestry of cruelty and avarice that stains the soul of our species for eternity.\"",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.zeyada(
                            fontSize: 48, color: Colors.white)),
                  )),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (state == 1) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Do not be intrigued by WINS",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.zeyada(
                                    fontSize: 48, color: Colors.white)),
                            IconButton(
                              onPressed: () {
                                current_card = 0;

                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) {
                                    return MainApp();
                                  },
                                ));
                              },
                              icon: const Icon(
                                Icons.replay_outlined,
                                color: Colors.white,
                              ),
                              iconSize: 48,
                            )
                          ],
                        );
                      }
                      if (state == -1) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Do not let your LOOSE win over you",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.zeyada(
                                    fontSize: 48, color: Colors.white)),
                            IconButton(
                              onPressed: () {
                                current_card = 0;

                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) {
                                    return MainApp();
                                  },
                                ));
                              },
                              icon: const Icon(
                                Icons.replay_outlined,
                                color: Colors.white,
                              ),
                              iconSize: 48,
                            )
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                  Center(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        ...cards
                            .map((e) => KCard(
                                  index: e,
                                  toggle: toggleState,
                                ))
                            .toList()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KCard extends StatelessWidget {
  KCard({super.key, required this.index, required this.toggle});
  int index;
  Function(int i) toggle;
  @override
  Widget build(BuildContext context) {
    var random = Random();
    var rndm = Random();
    FlipCardController controller = FlipCardController();
    return Transform.rotate(
      angle: (pi / 180) * random.nextInt(6) * (rndm.nextInt(2) == 1 ? -1 : 1),
      // angle: (pi / 180) * random.nextDouble(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FlipCard(
          onFlipDone: (isFront) {
            print(current_card);
            print(index.toString() + "," + isFront.toString());
            if (!isFront) {
              current_card = 0;
            }
            if (isFront) {
              if (current_card == 0) {
                current_card = index;
              } else if (current_card == index) {
                toggle(1);
                print("win");
              } else {
                toggle(-1);
                print("loose");
              }
            }
            print(current_card);
          },

          fill: Fill
              .fillBack, // Fill the back side of the card to make in the same size as the front.
          direction: FlipDirection.HORIZONTAL, // default
          side: CardSide.FRONT, // The side to initially display.
          front: Card(
            color: Colors.transparent,
            shadowColor: Colors.red,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 10,
            child: const Image(
              image: AssetImage("blue_card.png"),
              height: 270,
            ),
          ),
          back: Card(
            elevation: 20,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image(
                image: AssetImage(
                  "evils/${index}.png",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
