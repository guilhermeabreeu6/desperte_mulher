import 'package:flutter/material.dart';
import '../../Models/answer.dart';
import '../../Models/criterion.dart';
import '../../Models/quiz_page.dart';
import '../../common/app_routes.dart';
import '../../common/risk_calculator.dart';
import 'question_widget.dart';
import 'quiz_server.dart';

/// Questionário de avaliação de risco (metodologia AR PAX/FRIDA), dividido
/// em 5 Etapas carregadas de assets/Mock/page1.json..page5.json.
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizServer _server = QuizServer();

  bool _showIntro = true;
  bool _isLoading = false;
  int _currentPage = 1;
  int _lastPage = 1;

  final Map<int, QuizPageResponse> _pageCache = {};
  final Map<int, List<Set<Answer>>> _pageSelections = {};

  bool get _isFirstPage => _currentPage == 1;
  bool get _isLastPage => _currentPage == _lastPage;

  Future<void> _startQuiz() async {
    setState(() => _showIntro = false);
    await _loadPage(1);
  }

  Future<void> _loadPage(int page) async {
    setState(() => _isLoading = true);

    if (!_pageCache.containsKey(page)) {
      final result = await _server.fetchQuestions(page);
      _pageCache[page] = result;
      _pageSelections[page] = List.generate(
        result.questions.length,
        (_) => <Answer>{},
      );
    }

    if (!mounted) return;

    final result = _pageCache[page]!;
    setState(() {
      _currentPage = page;
      _lastPage = result.lastPage;
      _isLoading = false;
    });
  }

  void _onQuestionChanged(int index, Set<Answer> selected) {
    _pageSelections[_currentPage]![index] = selected;
  }

  Map<Criterion, int> _computeRawTotals() {
    final totals = {for (final criterion in Criterion.values) criterion: 0};

    for (final pageEntry in _pageCache.entries) {
      final questions = pageEntry.value.questions;
      final selections = _pageSelections[pageEntry.key]!;

      for (var i = 0; i < questions.length; i++) {
        final activated = selections[i].any((answer) => answer.activates);
        if (!activated) continue;

        for (final criterion in questions[i].criteria) {
          totals[criterion] = (totals[criterion] ?? 0) + 1;
        }
      }
    }

    return totals;
  }

  void _onAdvance() {
    if (_isLastPage) {
      _showResult();
    } else {
      _loadPage(_currentPage + 1);
    }
  }

  void _onBack() {
    if (_isFirstPage) {
      setState(() => _showIntro = true);
    } else {
      _loadPage(_currentPage - 1);
    }
  }

  void _showResult() {
    final result = RiskCalculator.calculate(_computeRawTotals());
    Navigator.pushNamed(context, AppRoutes.resultPage, arguments: result);
  }

  @override
  Widget build(BuildContext context) {
    if (_showIntro) {
      return _buildIntro();
    }

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final page = _pageCache[_currentPage]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Etapa $_currentPage de $_lastPage'),
      ),
      body: Column(
        children: [
          _buildProgressHeader(page.stepTitle),
          Expanded(child: _buildQuestionsList(page)),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildIntro() {
    return Scaffold(
      appBar: AppBar(title: const Text('Avaliação de Risco')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Colors.amber.shade800),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Esta avaliação tem caráter informativo e não substitui '
                      'o atendimento de serviços especializados de proteção '
                      'à mulher. Mesmo um risco baixo deve ser levado a '
                      'sério — se você está em perigo imediato, procure '
                      'ajuda agora: disque 180 ou 190.',
                      style: TextStyle(color: Colors.amber.shade900),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Você vai responder a um questionário de 5 etapas sobre sua '
              'situação. Suas respostas são usadas apenas para calcular o '
              'seu grau de risco e não são enviadas a terceiros.',
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _startQuiz,
                child: const Text('Começar Avaliação'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressHeader(String stepTitle) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  stepTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '$_currentPage / $_lastPage',
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _currentPage / _lastPage,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF7B1FA2)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionsList(QuizPageResponse page) {
    final selections = _pageSelections[_currentPage]!;

    return ListView.separated(
      // Força uma nova posição de rolagem ao trocar de etapa — sem isso,
      // a etapa seguinte herdava o scroll (geralmente no fim) da anterior.
      key: ValueKey('quiz_list_page$_currentPage'),
      padding: const EdgeInsets.all(16),
      itemCount: page.questions.length,
      separatorBuilder: (_, __) => const Divider(height: 32),
      itemBuilder: (context, index) {
        return QuestionWidget(
          key: ValueKey('page${_currentPage}_question$index'),
          question: page.questions[index],
          initialSelection: selections[index],
          onChanged: (selected) => _onQuestionChanged(index, selected),
        );
      },
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: OutlinedButton(
                onPressed: _onBack,
                child: const Text('Voltar'),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _onAdvance,
                child: Text(_isLastPage ? 'Ver Resultado' : 'Avançar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
