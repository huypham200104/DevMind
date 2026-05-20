const fs = require('fs');
const path = require('path');

// IQ QUESTIONS GENERATION
const generateIqQuestions = () => {
  const questions = [];
  
  // 1. Number Sequence (30 questions)
  for (let i = 1; i <= 30; i++) {
    const start = i * 2;
    const diff = i;
    // Example sequence: start, start+diff, start+2*diff, ?, start+4*diff
    const a = start;
    const b = start + diff;
    const c = start + 2 * diff;
    const d = start + 3 * diff; // Correct
    const e = start + 4 * diff;
    
    questions.push({
      question: `Điền số tiếp theo vào dãy số: ${a}, ${b}, ${c}, ?, ${e}`,
      type: 'number_sequence',
      options: [
        (d - 1).toString(),
        d.toString(),
        (d + 1).toString(),
        (d + diff).toString()
      ],
      correctAnswer: 1, // index of d
      explanation: `Dãy số tăng dần với khoảng cách là ${diff}. Vì vậy: ${c} + ${diff} = ${d}.`,
      difficulty: i <= 10 ? 'easy' : (i <= 20 ? 'medium' : 'hard'),
      createdAt: new Date(),
    });
  }

  // 2. Logic (30 questions)
  for (let i = 1; i <= 30; i++) {
    questions.push({
      question: `Nếu "TẤT CẢ A là B" và "MỘT SỐ B là C". Khẳng định nào sau đây là chắc chắn ĐÚNG? (Câu hỏi Logic biến thể ${i})`,
      type: 'logic',
      options: [
        'Tất cả A là C',
        'Một số A là C',
        'Không thể kết luận chắc chắn',
        'Tất cả C là B'
      ],
      correctAnswer: 2,
      explanation: `Quy tắc tam đoạn luận: Từ "Tất cả A là B" và "Một số B là C" không thể suy ra mối quan hệ trực tiếp giữa A và C một cách chắc chắn. Có thể có hoặc không.`,
      difficulty: i <= 10 ? 'easy' : (i <= 20 ? 'medium' : 'hard'),
      createdAt: new Date(),
    });
  }

  // 3. Math Puzzle (25 questions)
  for (let i = 1; i <= 25; i++) {
    const x = i * 3;
    const y = i * 2;
    questions.push({
      question: `Hôm nay tuổi của cha gấp ${i + 2} lần tuổi con. Biết cha hơn con ${x * (i + 1)} tuổi. Hỏi con bao nhiêu tuổi?`,
      type: 'math_puzzle',
      options: [
        (x - 1).toString(),
        (x).toString(),
        (x + 1).toString(),
        (y).toString()
      ],
      correctAnswer: 1,
      explanation: `Gọi tuổi con là a. Tuổi cha là ${i + 2} * a. Cha hơn con ${i + 1} * a = ${x * (i + 1)}. Suy ra a = ${x}. Tuổi con là ${x}.`,
      difficulty: 'medium',
      createdAt: new Date(),
    });
  }

  // 4. Pattern (15 questions)
  for (let i = 1; i <= 15; i++) {
    questions.push({
      question: `Tìm hình khác biệt nhất so với 3 hình còn lại (Biến thể Pattern ${i})`,
      type: 'pattern',
      options: [
        'Hình tam giác có 1 đường chéo',
        'Hình vuông có 2 đường chéo',
        'Hình ngũ giác có 3 đường chéo',
        'Hình tròn không có đường chéo'
      ],
      correctAnswer: 3,
      explanation: `Hình tròn là hình duy nhất không có góc và không thể có đường chéo theo định nghĩa thông thường của đa giác.`,
      difficulty: 'easy',
      createdAt: new Date(),
    });
  }

  return questions;
};

// TECHNICAL QUESTIONS GENERATION
const generateTechnicalQuestions = () => {
  const questions = [];
  let idCounter = 1;

  const categories = [
    { id: 'flutter_dart', name: 'Flutter & Dart', count: 30 },
    { id: 'javascript', name: 'JavaScript', count: 25 },
    { id: 'react', name: 'React', count: 25 },
    { id: 'python', name: 'Python', count: 20 },
    { id: 'data_structures', name: 'Data Structures', count: 25 },
    { id: 'algorithms', name: 'Algorithms', count: 25 },
    { id: 'sql_database', name: 'SQL & Database', count: 20 },
    { id: 'system_design', name: 'System Design', count: 15 },
    { id: 'oop', name: 'OOP', count: 15 },
    { id: 'networking', name: 'Networking', count: 15 },
  ];

  categories.forEach(cat => {
    for (let i = 1; i <= cat.count; i++) {
      let diff = 'easy';
      if (i > cat.count * 0.3) diff = 'medium';
      if (i > cat.count * 0.7) diff = 'hard';

      questions.push({
        question: `[${cat.name}] Câu hỏi kỹ thuật số ${i}: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?`,
        options: [
          `Lựa chọn A (Sai phân tâm 1)`,
          `Lựa chọn B (Đúng cho ${cat.name})`,
          `Lựa chọn C (Sai phân tâm 2)`,
          `Lựa chọn D (Sai hoàn toàn)`
        ],
        correctAnswer: 1,
        explanation: `Lời giải cho câu hỏi ${i} thuộc chủ đề ${cat.name}. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.`,
        category: cat.id,
        difficulty: diff,
        createdAt: new Date(),
      });
      idCounter++;
    }
  });

  // Let's replace the first few with real, high-quality questions for realism
  const realQuestions = [
    {
      question: `Trong Flutter, vòng đời (lifecycle) của một StatefulWidget bắt đầu bằng phương thức nào?`,
      options: ['initState()', 'build()', 'createState()', 'didChangeDependencies()'],
      correctAnswer: 2,
      explanation: `Vòng đời bắt đầu bằng việc gọi createState() để tạo ra một instance của State object. Sau đó initState() mới được gọi trên State object đó.`,
      category: 'flutter_dart',
      difficulty: 'easy',
      createdAt: new Date(),
    },
    {
      question: `JavaScript Event Loop xử lý các task trong Microtask queue và Macrotask queue theo thứ tự nào?`,
      options: [
        'Macrotask queue chạy trước, sau đó mới đến Microtask queue.',
        'Sau mỗi Macrotask hoàn thành, toàn bộ Microtask queue sẽ được xử lý hết trước khi sang Macrotask tiếp theo.',
        'Chạy luân phiên 1 Macrotask rồi 1 Microtask.',
        'Tùy thuộc vào trình duyệt.'
      ],
      correctAnswer: 1,
      explanation: `Event Loop luôn ưu tiên dọn sạch Microtask queue (chứa Promise.then, MutationObserver) ngay sau khi call stack rỗng và sau khi kết thúc một Macrotask (setTimeout, setInterval).`,
      category: 'javascript',
      difficulty: 'hard',
      createdAt: new Date(),
    },
    {
      question: `Độ phức tạp thời gian (Time Complexity) trung bình của thuật toán QuickSort là bao nhiêu?`,
      options: ['O(N)', 'O(N log N)', 'O(N^2)', 'O(log N)'],
      correctAnswer: 1,
      explanation: `Trung bình QuickSort chia mảng làm 2 nửa tương đối đều nhau, mất log(N) bước chia, mỗi bước duyệt N phần tử. Tổng là O(N log N). Tuy nhiên trường hợp xấu nhất là O(N^2).`,
      category: 'algorithms',
      difficulty: 'medium',
      createdAt: new Date(),
    }
  ];

  // Merge real questions into the beginning
  for (let i = 0; i < realQuestions.length; i++) {
    questions[i] = realQuestions[i];
  }

  return questions;
};

// Write files
const iqQuestions = generateIqQuestions();
const techQuestions = generateTechnicalQuestions();

const iqContent = `module.exports = ${JSON.stringify(iqQuestions, null, 2)};`;
const techContent = `module.exports = ${JSON.stringify(techQuestions, null, 2)};`;

fs.writeFileSync(path.join(__dirname, 'iq_questions.js'), iqContent, 'utf-8');
fs.writeFileSync(path.join(__dirname, 'technical_questions.js'), techContent, 'utf-8');

console.log('✅ Generated iq_questions.js (100 questions)');
console.log('✅ Generated technical_questions.js (215 questions)');
