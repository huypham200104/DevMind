# DevMind AI

DevMind là một ứng dụng di động thông minh được xây dựng bằng **Flutter** và **Firebase**, ứng dụng sức mạnh của Trí tuệ nhân tạo (AI) để hỗ trợ các lập trình viên và ứng viên IT trong việc học tập, đánh giá năng lực và chuẩn bị cho quá trình tìm việc.

## 🎥 Video Demo

[Xem Video Demo Ứng Dụng](https://drive.google.com/file/d/1m7pVKEESQqtJNayxyOiDgDnJh1Ff2XEq/view?usp=drive_link)

## 🌟 Tính năng nổi bật

* 📄 **Quét và Phân tích CV (AI CV Scanner)**: Cho phép người dùng tải lên file CV (PDF). Trí tuệ nhân tạo đọc và đưa ra các nhận xét chuyên sâu, chỉ ra điểm mạnh, điểm yếu và các từ khóa kỹ năng cần bổ sung.
* 🔄 **Vòng lặp học tập thích ứng (Adaptive Learning Loop)**: Trực tiếp từ kết quả quét CV, AI tự động sinh bài kiểm tra trắc nghiệm tình huống thực tế (AI Gap Quiz) nhắm đúng các lỗ hổng kiến thức vừa được phát hiện, giúp ứng viên luyện tập khắc phục tức thì.
* 🧠 **Ôn tập Kỹ thuật (Technical Quizzes)**: Cung cấp kho câu hỏi đánh giá kỹ năng lập trình đa dạng (Python, JavaScript, Flutter, React, C++,...). Người dùng có thể tự tạo bộ câu hỏi tùy chỉnh.
* 🤖 **Giải thích bằng AI**: Tích hợp trợ lý ảo AI để giải thích chi tiết, cặn kẽ các câu hỏi khó ngay trong quá trình ôn tập.
* 🏆 **Bảng xếp hạng (Leaderboard)**: Thi đua điểm số với những người dùng khác thông qua hệ thống tích điểm.
* 💳 **Quản lý Ví (Wallet & Credits)**: Quản lý số lượt sử dụng AI (Lượt quét CV, Lượt AI giải thích). Người dùng có thể điểm danh hàng ngày hoặc nạp thêm lượt dùng.

## 🛠 Công nghệ sử dụng (Tech Stack)

* **Nền tảng**: [Flutter](https://flutter.dev/) (Cross-platform Mobile App)
* **Quản lý trạng thái (State Management)**: `provider`
* **Điều hướng (Routing)**: `go_router`
* **AI & LLM Integration**: Groq Cloud API (`llama-3.3-70b-versatile`), Few-shot Chain-of-Thought (CoT) Prompting, Strict JSON Schema Validation
* **Backend as a Service**: Firebase (Authentication, Cloud Functions v2, Firestore Database, Cloud Storage)
* **Testing**: `flutter_test` (Unit testing for Controllers, Repositories, and Business Logic)
* **UI/UX**: Custom Design System mang phong cách Glassy/Modern UI

## 📁 Cấu trúc thư mục

Dự án áp dụng kiến trúc **Feature-First** (phân mảnh theo tính năng) để code luôn sạch sẽ và dễ dàng mở rộng:

```text
lib/
├── app/                  # Các cấu hình gốc: Router, Theme, Màu sắc chung
├── core/                 # Các thành phần dùng chung (AppHeader, Dialog, Buttons, Utils)
└── features/             # Chứa các tính năng cốt lõi
    ├── auth/             # Đăng nhập, Đăng ký, Profile người dùng
    ├── cv_scanner/       # Upload CV, Quét điểm yếu và Kích hoạt Adaptive AI Quiz
    ├── home/             # Màn hình chính, Navigation bar, Check-in hàng ngày
    ├── ranking/          # Bảng xếp hạng người dùng
    ├── technical_quiz/   # Hệ thống bài test kỹ năng lập trình & Adaptive Quiz Session
    └── wallet/           # Quản lý ví, nạp thêm lượt sử dụng AI
```

## 🚀 Hướng dẫn cài đặt

1. **Clone dự án về máy:**
   ```bash
   git clone https://github.com/huypham200104/DevMind.git
   ```

2. **Truy cập thư mục mã nguồn Flutter:**
   ```bash
   cd DevMind/devmind_app
   ```

3. **Cài đặt các thư viện phụ thuộc:**
   ```bash
   flutter pub get
   ```

4. **Cấu hình Firebase:**
   * Bạn cần cung cấp các file cấu hình từ Firebase Console.
   * Thêm `google-services.json` vào `android/app/`.
   * Thêm `GoogleService-Info.plist` vào thư mục `ios/Runner/`.

5. **Chạy ứng dụng:**
   ```bash
   flutter run
   ```

---
## 🌟 Điểm nhấn Kỹ thuật (Technical Highlights)

* **Adaptive Learning Loop (Vòng lặp học tập thích ứng)**: Kết nối chặt chẽ giữa AI CV Scanner và Technical Quiz. Cloud Function ứng dụng mô hình LLM tiên tiến với Few-shot CoT prompting để tạo ra các câu hỏi tình huống thực tế (scenario-based & code snippets), ép chặt JSON Schema để đảm bảo 0% lỗi format trước khi lưu vào Firestore.
* **Clean Architecture & SOLID**: Dự án tuân thủ nguyên lý thiết kế SRP (Single Responsibility Principle) thông qua việc module hoá logic và chia nhỏ các Provider/Controller (tách rời Controller quản lý khoá học, Controller thi trắc nghiệm, Controller scan CV).
* **Tối ưu Hiệu năng (Performance)**: State Management được thiết kế chặt chẽ. Hệ thống đếm giờ thi (Timer) sử dụng `ValueNotifier` kết hợp `ValueListenableBuilder` để đảm bảo UI không bị render lại (rebuild) lãng phí mỗi giây, duy trì 60 FPS mượt mà.
* **Bảo vệ rò rỉ bộ nhớ (Memory Leak Prevention)**: Ứng dụng mô hình Scoped Controller kết hợp với Lifecycle Hook, cho phép các tiến trình ngầm (Timer, StreamSubscription) tự động huỷ bỏ (dispose) triệt để khi người dùng rời màn hình.
* **Automated Testing**: Thiết lập bộ kiểm thử tự động (Unit Test) cho các Controller và Repository tầng Domain/Data, đảm bảo tính ổn định và ngăn ngừa lỗi hồi quy khi ứng dụng mở rộng.

## 🤝 Đóng góp (Contributing)

Mọi đóng góp nhằm cải thiện DevMind AI luôn được chào đón. Nếu bạn muốn đóng góp code:
1. Fork dự án này.
2. Tạo một nhánh tính năng mới (`git checkout -b feature/AmazingFeature`).
3. Commit các thay đổi (`git commit -m 'Add some AmazingFeature'`).
4. Push lên nhánh (`git push origin feature/AmazingFeature`).
5. Tạo Pull Request.

## 📄 Giấy phép (License)

Dự án được phân phối dưới giấy phép MIT. Xem file `LICENSE` để biết thêm chi tiết.

---
*Phát triển bởi [Huy Pham]*
