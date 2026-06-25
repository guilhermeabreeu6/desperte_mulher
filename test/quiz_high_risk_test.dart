// Testa o fluxo do questionário respondendo a primeira opção (tipicamente a
// mais grave) em todas as questões. Resultado esperado pela Matriz de Risco
// AR PAX: Extremo (100%) — validado também por simulação independente em
// Python contra o mesmo algoritmo.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:desperte_mulher/Models/answer.dart';
import 'package:desperte_mulher/main.dart';

void main() {
  testWidgets(
    'respondendo a opção mais grave em tudo resulta em risco Extremo (100%)',
    (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      expect(find.text('Desperte Mulher'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField).first, 'teste@teste.com');
      await tester.enterText(find.byType(TextFormField).last, 'senha123');
      await tester.tap(find.text('Entrar'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Começar Avaliação'));
      await tester.pumpAndSettle();

      for (var page = 1; page <= 5; page++) {
        var index = 0;
        while (true) {
          final questionFinder = find.byKey(
            ValueKey('page${page}_question$index'),
          );

          try {
            await tester.scrollUntilVisible(
              questionFinder,
              200.0,
              scrollable: find.byType(Scrollable),
            );
          } catch (_) {
            break;
          }
          await tester.pumpAndSettle();

          final radioFinder = find.descendant(
            of: questionFinder,
            matching: find.byType(RadioListTile<Answer>),
          );
          final checkboxFinder = find.descendant(
            of: questionFinder,
            matching: find.byType(CheckboxListTile),
          );

          if (tester.widgetList(radioFinder).isNotEmpty) {
            await tester.tap(radioFinder.first);
          } else if (tester.widgetList(checkboxFinder).isNotEmpty) {
            await tester.tap(checkboxFinder.first);
          }
          await tester.pumpAndSettle();

          index++;
        }

        final isLastPage = page == 5;
        final advanceButton = find.widgetWithText(
          ElevatedButton,
          isLastPage ? 'Ver Resultado' : 'Avançar',
        );
        await tester.ensureVisible(advanceButton);
        await tester.pumpAndSettle();
        await tester.tap(advanceButton);
        await tester.pumpAndSettle();
      }

      expect(find.text('Grau de Risco'), findsOneWidget);
      expect(find.text('Extremo'), findsOneWidget);
      expect(find.text('100%'), findsOneWidget);
    },
  );
}
