import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/mock_repository.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key, required this.repository});

  final MockRepository repository;

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  static const _examDurationSeconds = 180;

  Timer? _timer;
  int _secondsLeft = _examDurationSeconds;
  int _current = 0;
  final Map<int, int> _answers = {};
  bool _submitted = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startExam() {
    _timer?.cancel();
    setState(() {
      _submitted = false;
      _current = 0;
      _answers.clear();
      _secondsLeft = _examDurationSeconds;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        _submit(auto: true);
      } else {
        setState(() => _secondsLeft -= 1);
      }
    });
  }

  void _submit({bool auto = false}) {
    if (_submitted) return;
    _timer?.cancel();
    setState(() => _submitted = true);

    if (auto && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Time is up. Exam submitted automatically.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.repository.getExamQuestions();
    final question = questions[_current];
    final minutes = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');

    var score = 0;
    for (var i = 0; i < questions.length; i++) {
      if (_answers[i] == questions[i].correctIndex) {
        score++;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Engine (Demo)'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(child: Text('$minutes:$seconds')),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              children: [
                FilledButton(
                  onPressed: _startExam,
                  child: const Text('Start / Restart'),
                ),
                OutlinedButton(
                  onPressed: _submitted ? null : () => _submit(),
                  child: const Text('Submit'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Question ${_current + 1}/${questions.length}'),
            const SizedBox(height: 8),
            Text(question.text, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...List.generate(question.choices.length, (choiceIndex) {
              return RadioListTile<int>(
                value: choiceIndex,
                groupValue: _answers[_current],
                title: Text(question.choices[choiceIndex]),
                onChanged: _submitted
                    ? null
                    : (value) {
                        if (value == null) return;
                        setState(() => _answers[_current] = value);
                      },
              );
            }),
            Row(
              children: [
                OutlinedButton(
                  onPressed: _current == 0
                      ? null
                      : () => setState(() => _current -= 1),
                  child: const Text('Prev'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: _current == questions.length - 1
                      ? null
                      : () => setState(() => _current += 1),
                  child: const Text('Next'),
                ),
              ],
            ),
            const Spacer(),
            if (_submitted)
              Text(
                'Result: $score / ${questions.length} (${(score / questions.length * 100).toStringAsFixed(0)}%)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
          ],
        ),
      ),
    );
  }
}
