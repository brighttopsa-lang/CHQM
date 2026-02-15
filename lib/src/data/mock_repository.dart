import '../models/entities.dart';

class MockRepository {
  const MockRepository();

  List<Course> getCourses() {
    return const [
      Course(
        id: 'cppx-01',
        title: 'Certified Patient Experience (CPPX)',
        category: 'Patient Experience',
        durationHours: 24,
        price: 299,
      ),
      Course(
        id: 'ic-01',
        title: 'Infection Control Essentials',
        category: 'Clinical Quality',
        durationHours: 18,
        price: 199,
      ),
      Course(
        id: 'qm-01',
        title: 'Healthcare Quality Management',
        category: 'Quality',
        durationHours: 30,
        price: 349,
      ),
    ];
  }

  List<ExamQuestion> getExamQuestions() {
    return const [
      ExamQuestion(
        id: 'q1',
        text: 'What is the first step in quality improvement?',
        choices: ['Audit', 'Define problem', 'Implement solution', 'Close case'],
        correctIndex: 1,
      ),
      ExamQuestion(
        id: 'q2',
        text: 'Patient-centered care primarily focuses on:',
        choices: ['Revenue', 'Equipment', 'Patient values', 'Staff uniforms'],
        correctIndex: 2,
      ),
      ExamQuestion(
        id: 'q3',
        text: 'A KPI is best described as:',
        choices: ['Final certificate', 'Performance metric', 'Exam policy', 'Shipping status'],
        correctIndex: 1,
      ),
    ];
  }

  List<Certificate> getCertificates() {
    return [
      Certificate(
        id: 'cert-1001',
        courseTitle: 'Certified Patient Experience (CPPX)',
        issueDate: DateTime(2026, 1, 12),
        verificationCode: 'AIMSM-CPPX-1001',
      ),
    ];
  }
}
