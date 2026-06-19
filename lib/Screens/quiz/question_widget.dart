import 'package:flutter/material.dart';
import '../../Models/answer.dart';
import '../../Models/question.dart';

/// Renderiza uma questão e informa ao widget pai qual o conjunto de
/// respostas selecionadas, para que o estado possa ser preservado ao
/// navegar entre etapas (botão Voltar).
class QuestionWidget extends StatefulWidget {
  final Question question;
  final Set<Answer> initialSelection;
  final ValueChanged<Set<Answer>>? onChanged;

  const QuestionWidget({
    super.key,
    required this.question,
    this.initialSelection = const {},
    this.onChanged,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late Set<Answer> _selected;

  @override
  void initState() {
    super.initState();
    _selected = Set<Answer>.from(widget.initialSelection);
  }

  void _selectSingle(Answer answer) {
    setState(() {
      _selected = {answer};
    });
    widget.onChanged?.call(_selected);
  }

  void _toggleMultiple(Answer answer) {
    setState(() {
      if (_selected.contains(answer)) {
        _selected.remove(answer);
      } else {
        // Respostas negativas (ex.: "Não") são mutuamente exclusivas com
        // as demais opções da mesma pergunta.
        if (!answer.activates) {
          _selected.clear();
        } else {
          _selected.removeWhere((a) => !a.activates);
        }
        _selected.add(answer);
      }
    });
    widget.onChanged?.call(_selected);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestionTitle(),
        const SizedBox(height: 12),
        widget.question.type == QuestionType.single
            ? _buildSingleChoice()
            : _buildMultipleChoice(),
      ],
    );
  }

  Widget _buildQuestionTitle() {
    return Text(
      widget.question.title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSingleChoice() {
    final selected = _selected.isEmpty ? null : _selected.first;
    return Column(
      children: widget.question.answers.map((answer) {
        return RadioListTile<Answer>(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: Text(answer.title),
          value: answer,
          groupValue: selected,
          onChanged: (value) {
            if (value != null) _selectSingle(value);
          },
        );
      }).toList(),
    );
  }

  Widget _buildMultipleChoice() {
    return Column(
      children: widget.question.answers.map((answer) {
        return CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: Text(answer.title),
          value: _selected.contains(answer),
          onChanged: (_) => _toggleMultiple(answer),
        );
      }).toList(),
    );
  }
}
