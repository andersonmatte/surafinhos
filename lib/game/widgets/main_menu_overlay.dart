import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../doodle_dash.dart';

// Overlay that appears for the main menu
class MainMenuOverlay extends StatefulWidget {
  const MainMenuOverlay(this.game, {super.key});

  final Game game;

  @override
  State<MainMenuOverlay> createState() => _MainMenuOverlayState();
}

class _MainMenuOverlayState extends State<MainMenuOverlay> {
  Character character = Character.alicia;

  @override
  Widget build(BuildContext context) {
    DoodleDash game = widget.game as DoodleDash;

    return LayoutBuilder(builder: (context, constraints) {
      final characterWidth = constraints.maxWidth / 4;

      final TextStyle titleStyle = (constraints.maxWidth > 830)
          ? Theme.of(context).textTheme.displayLarge!
          : Theme.of(context).textTheme.displaySmall!;

      // 760 is the smallest height the browser can have until the
      // layout is too large to fit.
      final bool screenHeightIsSmall = constraints.maxHeight < 760;

      return Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Surafinhos',
                    style: titleStyle.copyWith(
                      height: .8,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Selecione um personagem:',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.background)),
                  ),
                  if (!screenHeightIsSmall) const WhiteSpace(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CharacterButton(
                            character: Character.alicia,
                            selected: character == Character.alicia,
                            onSelectChar: () {
                              setState(() {
                                character = Character.alicia;
                              });
                            },
                            characterWidth: characterWidth,
                          ),
                          CharacterButton(
                            character: Character.julia,
                            selected: character == Character.julia,
                            onSelectChar: () {
                              setState(() {
                                character = Character.julia;
                              });
                            },
                            characterWidth: characterWidth,
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // Add spacing between rows
                      CharacterButton(
                        character: Character.joao,
                        // Replace with the actual character enum value
                        selected: character == Character.joao,
                        // Replace with the appropriate condition
                        onSelectChar: () {
                          setState(() {
                            character = Character
                                .julia; // Replace with the actual character enum value
                          });
                        },
                        characterWidth: characterWidth,
                      ),
                    ],
                  ),
                  if (!screenHeightIsSmall) const WhiteSpace(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dificuldade:',
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.background)),
                      LevelPicker(
                        level: game.levelManager.selectedLevel.toDouble(),
                        label: game.levelManager.selectedLevel.toString(),
                        onChanged: ((value) {
                          setState(() {
                            game.levelManager.selectLevel(value.toInt());
                          });
                        }),
                      ),
                    ],
                  ),
                  if (!screenHeightIsSmall) const WhiteSpace(height: 50),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        game.gameManager.selectCharacter(character);
                        game.startGame();
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size(200, 50),
                        ),
                        textStyle: MaterialStateProperty.all(
                            Theme.of(context).textTheme.titleLarge),
                      ),
                      child: const Text('Start', style: TextStyle(
      fontSize: 20,
      color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class LevelPicker extends StatelessWidget {
  const LevelPicker({
    super.key,
    required this.level,
    required this.label,
    required this.onChanged,
  });

  final double level;
  final String label;
  final void Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Slider(
      value: level,
      max: 5,
      min: 1,
      divisions: 4,
      label: label,
      onChanged: onChanged,
    ));
  }
}

class CharacterButton extends StatelessWidget {
  const CharacterButton(
      {super.key,
      required this.character,
      this.selected = false,
      required this.onSelectChar,
      required this.characterWidth});

  final Character character;
  final bool selected;
  final void Function() onSelectChar;
  final double characterWidth;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: (selected)
          ? ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(31, 64, 195, 255)))
          : null,
      onPressed: onSelectChar,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/game/${character.name}_center.png',
              height: characterWidth,
              width: characterWidth,
            ),
            const WhiteSpace(height: 18),
            Text(
              character.name.toUpperCase(),
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class WhiteSpace extends StatelessWidget {
  const WhiteSpace({super.key, this.height = 100});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
