// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../doodle_dash.dart';
import 'widgets.dart';

// Overlay that pops up when the game ends
class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay(this.game, {super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.onTertiary,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Game Over',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(),
              ),
              const WhiteSpace(height: 50),
              ScoreDisplay(
                game: game,
                isLight: true,
              ),
              const WhiteSpace(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  (game as DoodleDash).resetGame();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(250, 50),
                  ),
                  textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.titleLarge),
                ),
                child: const Text('Jogar De Novo',  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white)),
              ),
              const WhiteSpace(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainMenuOverlay(this.game)),
                  );
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(250, 50),
                  ),
                  textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.titleLarge),
                ),
                child: const Text('Voltar',  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
