module.exports = [
  {
    "question": "Trong Flutter, vòng đời (lifecycle) của một StatefulWidget bắt đầu bằng phương thức nào?",
    "options": [
      "initState()",
      "build()",
      "createState()",
      "didChangeDependencies()"
    ],
    "correctAnswer": 2,
    "explanation": "Vòng đời bắt đầu bằng việc gọi createState() để tạo ra một instance của State object. Sau đó initState() mới được gọi trên State object đó.",
    "category": "flutter_dart",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "JavaScript Event Loop xử lý các task trong Microtask queue và Macrotask queue theo thứ tự nào?",
    "options": [
      "Macrotask queue chạy trước, sau đó mới đến Microtask queue.",
      "Sau mỗi Macrotask hoàn thành, toàn bộ Microtask queue sẽ được xử lý hết trước khi sang Macrotask tiếp theo.",
      "Chạy luân phiên 1 Macrotask rồi 1 Microtask.",
      "Tùy thuộc vào trình duyệt."
    ],
    "correctAnswer": 1,
    "explanation": "Event Loop luôn ưu tiên dọn sạch Microtask queue (chứa Promise.then, MutationObserver) ngay sau khi call stack rỗng và sau khi kết thúc một Macrotask (setTimeout, setInterval).",
    "category": "javascript",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "Độ phức tạp thời gian (Time Complexity) trung bình của thuật toán QuickSort là bao nhiêu?",
    "options": [
      "O(N)",
      "O(N log N)",
      "O(N^2)",
      "O(log N)"
    ],
    "correctAnswer": 1,
    "explanation": "Trung bình QuickSort chia mảng làm 2 nửa tương đối đều nhau, mất log(N) bước chia, mỗi bước duyệt N phần tử. Tổng là O(N log N). Tuy nhiên trường hợp xấu nhất là O(N^2).",
    "category": "algorithms",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 4: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 4 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 5: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 5 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 6: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 6 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 7: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 7 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 8: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 8 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 9: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 9 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 10: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 10 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 11: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 11 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 12: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 12 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 13: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 13 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 14: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 14 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 15: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 15 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 16: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 16 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 17: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 17 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 18: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 18 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 19: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 19 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 20: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 20 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 21: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 21 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 22: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 22 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 23: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 23 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 24: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 24 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 25: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 25 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 26: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 26 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 27: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 27 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 28: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 28 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 29: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 29 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Flutter & Dart] Câu hỏi kỹ thuật số 30: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Flutter & Dart)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 30 thuộc chủ đề Flutter & Dart. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "flutter_dart",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 1: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 1 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 2: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 2 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 3: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 3 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 4: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 4 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 5: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 5 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 6: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 6 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 7: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 7 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 8: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 8 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 9: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 9 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 10: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 10 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 11: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 11 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 12: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 12 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 13: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 13 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 14: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 14 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 15: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 15 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 16: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 16 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 17: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 17 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 18: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 18 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 19: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 19 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 20: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 20 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 21: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 21 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 22: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 22 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 23: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 23 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 24: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 24 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[JavaScript] Câu hỏi kỹ thuật số 25: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho JavaScript)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 25 thuộc chủ đề JavaScript. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "javascript",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 1: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 1 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 2: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 2 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 3: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 3 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 4: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 4 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 5: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 5 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 6: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 6 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 7: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 7 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 8: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 8 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 9: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 9 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 10: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 10 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 11: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 11 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 12: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 12 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 13: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 13 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 14: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 14 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 15: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 15 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 16: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 16 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 17: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 17 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 18: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 18 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 19: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 19 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 20: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 20 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 21: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 21 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 22: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 22 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 23: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 23 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 24: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 24 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[React] Câu hỏi kỹ thuật số 25: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho React)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 25 thuộc chủ đề React. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "react",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 1: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 1 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 2: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 2 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 3: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 3 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 4: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 4 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 5: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 5 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 6: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 6 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 7: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 7 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 8: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 8 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 9: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 9 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 10: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 10 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 11: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 11 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 12: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 12 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 13: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 13 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 14: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 14 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 15: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 15 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 16: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 16 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 17: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 17 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 18: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 18 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 19: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 19 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Python] Câu hỏi kỹ thuật số 20: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Python)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 20 thuộc chủ đề Python. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "python",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 1: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 1 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 2: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 2 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 3: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 3 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 4: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 4 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 5: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 5 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 6: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 6 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 7: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 7 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 8: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 8 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 9: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 9 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 10: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 10 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 11: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 11 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 12: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 12 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 13: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 13 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 14: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 14 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 15: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 15 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 16: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 16 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 17: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 17 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 18: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 18 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 19: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 19 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 20: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 20 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 21: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 21 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 22: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 22 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 23: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 23 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 24: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 24 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Data Structures] Câu hỏi kỹ thuật số 25: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Data Structures)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 25 thuộc chủ đề Data Structures. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "data_structures",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 1: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 1 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 2: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 2 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 3: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 3 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 4: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 4 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 5: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 5 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 6: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 6 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 7: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 7 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 8: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 8 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 9: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 9 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 10: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 10 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 11: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 11 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 12: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 12 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 13: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 13 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 14: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 14 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 15: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 15 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 16: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 16 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 17: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 17 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 18: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 18 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 19: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 19 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 20: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 20 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 21: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 21 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 22: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 22 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 23: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 23 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 24: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 24 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Algorithms] Câu hỏi kỹ thuật số 25: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Algorithms)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 25 thuộc chủ đề Algorithms. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "algorithms",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 1: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 1 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 2: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 2 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 3: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 3 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 4: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 4 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 5: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 5 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 6: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 6 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 7: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 7 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 8: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 8 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 9: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 9 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 10: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 10 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 11: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 11 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 12: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 12 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 13: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 13 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 14: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 14 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 15: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 15 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 16: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 16 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 17: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 17 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 18: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 18 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 19: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 19 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[SQL & Database] Câu hỏi kỹ thuật số 20: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho SQL & Database)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 20 thuộc chủ đề SQL & Database. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "sql_database",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 1: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 1 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 2: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 2 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 3: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 3 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 4: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 4 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 5: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 5 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 6: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 6 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 7: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 7 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 8: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 8 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 9: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 9 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 10: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 10 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 11: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 11 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 12: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 12 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 13: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 13 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 14: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 14 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[System Design] Câu hỏi kỹ thuật số 15: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho System Design)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 15 thuộc chủ đề System Design. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "system_design",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 1: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 1 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 2: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 2 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 3: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 3 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 4: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 4 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 5: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 5 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 6: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 6 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 7: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 7 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 8: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 8 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 9: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 9 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 10: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 10 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 11: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 11 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 12: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 12 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 13: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 13 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 14: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 14 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[OOP] Câu hỏi kỹ thuật số 15: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho OOP)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 15 thuộc chủ đề OOP. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "oop",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 1: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 1 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 2: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 2 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 3: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 3 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 4: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 4 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "easy",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 5: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 5 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 6: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 6 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 7: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 7 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 8: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 8 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 9: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 9 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 10: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 10 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "medium",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 11: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 11 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 12: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 12 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 13: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 13 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 14: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 14 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  },
  {
    "question": "[Networking] Câu hỏi kỹ thuật số 15: Đặc điểm cốt lõi nhất cần lưu ý khi làm việc với công nghệ này là gì?",
    "options": [
      "Lựa chọn A (Sai phân tâm 1)",
      "Lựa chọn B (Đúng cho Networking)",
      "Lựa chọn C (Sai phân tâm 2)",
      "Lựa chọn D (Sai hoàn toàn)"
    ],
    "correctAnswer": 1,
    "explanation": "Lời giải cho câu hỏi 15 thuộc chủ đề Networking. Việc hiểu rõ bản chất (Lựa chọn B) giúp tối ưu hiệu năng và tránh memory leak trong các dự án thực tế.",
    "category": "networking",
    "difficulty": "hard",
    "createdAt": "2026-05-20T06:57:45.079Z"
  }
];