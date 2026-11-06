const assert = require("node:assert");
const test = require("node:test");
const { normalizeAdaptiveQuizResult } = require("../index.js");

test("normalizeAdaptiveQuizResult sanitizes valid and edge-case quiz output", () => {
  const rawData = {
    title: "AI Gap Quiz: Flutter Developer",
    description: "Khóa ôn luyện trọng tâm kiến thức",
    questions: [
      {
        question: "Trong Flutter, khi nào nên sử dụng InheritedWidget?",
        options: ["A", "B", "C", "D"],
        correctAnswerIndex: 1,
        explanation: "InheritedWidget giúp truyền dữ liệu xuống widget con hiệu quả.",
        category: "State Management"
      }
    ]
  };

  const normalized = normalizeAdaptiveQuizResult(rawData, "Flutter Developer");
  assert.strictEqual(normalized.title, "AI Gap Quiz: Flutter Developer");
  assert.strictEqual(normalized.questions.length, 1);
  assert.strictEqual(normalized.questions[0].correctAnswerIndex, 1);
  assert.strictEqual(normalized.questions[0].category, "State Management");
});

test("normalizeAdaptiveQuizResult repairs invalid answer index and empty questions", () => {
  const rawData = {
    title: "",
    questions: [
      {
        question: "Câu hỏi test",
        options: ["1", "2"],
        correctAnswerIndex: 99,
        explanation: "",
      }
    ]
  };

  const normalized = normalizeAdaptiveQuizResult(rawData, "Dev");
  assert.strictEqual(normalized.questions[0].correctAnswerIndex, 0);
  assert.strictEqual(normalized.questions[0].options.length, 4);
  assert.strictEqual(normalized.title.includes("Dev"), true);
});
