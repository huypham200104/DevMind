# DevMind AI — Design System & Quiz UI/UX Specification

> **Version:** 2.0  
> **Target Platform:** Mobile (iOS / Android) — Flutter  
> **Aesthetic Philosophy:** Modern Glassmorphism, Clean High-Contrast EdTech, Ergonomic One-Hand Interaction.

---

## 1. Triết lý Thiết kế (Design Philosophy)

DevMind AI hướng tới trải nghiệm học tập và phỏng vấn kỹ thuật nghiêm túc nhưng lôi cuốn, loại bỏ cảm giác căng thẳng của các bài thi truyền thống nhờ vào giao diện **Glassy/Modern UI**, màu sắc sinh động và sự phản hồi trực quan tức thì:

1. **Clarity Over Clutter (Rõ ràng trên hết):** Trong phòng thi, nội dung câu hỏi và code snippet là tâm điểm. Mọi thành phần phụ trợ (bộ đếm giờ, tiến độ) phải gọn gàng, không làm xao nhãng.
2. **Instant Feedback & Gamification (Phản hồi tức thì):** Chuyển đổi trạng thái phương án chọn mượt mà (chọn $\rightarrow$ đúng/sai), hiển thị chuỗi câu đúng (Streak Flame) và cộng điểm trực tiếp để tạo động lực.
3. **Ergonomic Thumb-Zone:** Nút hành động chính (Tiếp tục, Nộp bài, Hỏi trợ lý AI) luôn nằm ở 1/3 dưới màn hình — khu vực ngón tay cái dễ chạm tới nhất khi dùng một tay.

---

## 2. Hệ Thống Màu Sắc (Color Tokens)

Toàn bộ hệ thống màu sắc tuân thủ bảng mã màu chuẩn hiện tại trong [`AppColors`](file:///c:/Workplace/GitHub/DevMind/devmind_app/lib/app/theme/app_colors.dart):

```
       Primary Brand                      Semantic Accents                     Neutral Surfaces
 ┌──────────────────────┐             ┌──────────────────────┐             ┌──────────────────────┐
 │ #2ACDC1  (Teal)      │             │ #16A34A  (Success)   │             │ #F9F9F9 (Background) │
 ├──────────────────────┤             ├──────────────────────┤             ├──────────────────────┤
 │ #008D80  (Deep Teal) │             │ #F59E0B  (Warning)   │             │ #FFFFFF (Surface)    │
 ├──────────────────────┤             ├──────────────────────┤             ├──────────────────────┤
 │ #14B8A6  (Teal Dark) │             │ #DC2626  (Danger)    │             │ #1A1C1C (Text Main)  │
 └──────────────────────┘             └──────────────────────┘             └──────────────────────┘
```

### 2.1. Brand Palette
| Token Name | Hex Code | RGB | Vai trò giao diện |
| :--- | :--- | :--- | :--- |
| `primary` | `#2ACDC1` | `rgb(42, 205, 193)` | Màu thương hiệu chính, nút CTA, thanh tiến độ |
| `primaryGradientEnd` | `#008D80` | `rgb(0, 141, 128)` | Điểm kết thúc gradient, icon stroke, text nhấn mạnh |
| `primaryDark` | `#14B8A6` | `rgb(20, 184, 166)` | Hover, active states, badge background |
| `secondary` | `#14B8A6` | `rgb(20, 184, 166)` | Điểm nhấn phụ, tag kỹ năng |

### 2.2. Neutrals & Surfaces
| Token Name | Hex Code | Vai trò |
| :--- | :--- | :--- |
| `background` | `#F9F9F9` | Nền chung toàn màn hình, dịu mắt khi đọc lâu |
| `headerBackground` | `#F7F8F9` | Nền Glassy App Bar |
| `surface` | `#FFFFFF` | Nền thẻ câu hỏi, card phương án, modal |
| `inputSurface` | `#E2E2E2` | Nền ô nhập liệu |
| `border` | `#E2E2E2` | Viền ngăn cách tiêu chuẩn |
| `borderStrong` | `#BBCAC7` | Viền thẻ khi chưa chọn |
| `glassyBorder` | `#D8EEE9` | Viền hiệu ứng bóng mờ kết hợp nền Teal |
| `glassyBorderActive`| `#BBE5DD` | Viền thẻ đang active / được chọn |

### 2.3. Semantic Accents
| Token Name | Hex Code | Ứng dụng trong Quiz |
| :--- | :--- | :--- |
| `success` | `#16A34A` | Phương án trả lời đúng, điểm cao $\ge 80\%$ |
| `warning` | `#F59E0B` | Cảnh báo timer $\le 60$ giây, chuỗi câu đúng (Streak) |
| `danger` | `#DC2626` | Phương án chọn sai, hết giờ làm bài |

### 2.4. Typography Colors
| Token Name | Hex Code | Sử dụng |
| :--- | :--- | :--- |
| `textPrimary` | `#1A1C1C` | Tiêu đề câu hỏi, nội dung chính (Contrast 14:1) |
| `textSecondary` | `#3C4947` | Giải thích chi tiết, nhãn phụ, số câu hỏi |
| `textMuted` | `#5E5E5E` | Placeholder, thời gian phụ |

---

## 3. Hệ Thống Typography (Plus Jakarta Sans)

Font chữ chính: **Plus Jakarta Sans** (Đã tích hợp đầy đủ weights trong assets).

| Style | Size | Weight | Line Height | Ứng dụng Quiz |
| :--- | :--- | :--- | :--- | :--- |
| `displaySmall` | 28px | ExtraBold (800) | 1.2 | Điểm số tổng kết bài thi (Result Screen) |
| `headlineMedium`| 24px | Bold (700) | 1.25 | Tiêu đề khóa học, Tiêu đề Modal |
| `headlineSmall` | 21px | Bold (700) | 1.28 | Đồng hồ đếm ngược, Tên bài trắc nghiệm |
| `titleLarge` | 18px | Bold (700) | 1.32 | Nội dung câu hỏi chính |
| `titleMedium` | 15px | SemiBold (600) | 1.38 | Tiêu đề phương án A, B, C, D |
| `titleSmall` | 14px | SemiBold (600) | 1.36 | Tên tag danh mục, Breadcrumb |
| `bodyLarge` | 15px | Regular (400) | 1.48 | Đoạn văn mô tả, giải thích AI chi tiết |
| `bodyMedium` | 14px | Regular (400) | 1.45 | Nội dung phương án trả lời |
| `labelLarge` | 14px | Bold (700) | 1.25 | Chữ trong nút bấm CTA |
| `labelSmall` | 11px | SemiBold (600) | 1.30 | Nhãn phụ, chỉ số câu "Câu 3 / 10" |

---

## 4. Hệ Thống Icon Duotone (Assets Catalog)

Toàn bộ 12 icons mới được lưu trữ tại `devmind_app/assets/icons/`, thiết kế chuẩn **Duotone Two-Tone Style** với stroke 2px và lớp mảng màu Teal 15-22% opacity:

| Icon File | Tên biểu tượng | Ý nghĩa & Vị trí hiển thị |
| :--- | :--- | :--- |
| `quiz_timer.svg` | **Quiz Timer** | Đồng hồ đếm ngược góc trên phòng thi, cảnh báo thời gian |
| `streak_flame.svg` | **Streak Flame** | Ngọn lửa chuỗi trả lời đúng liên tục (Gamification) |
| `ai_sparkle.svg` | **AI Sparkle** | Nút "Hỏi AI giải thích" / Trợ lý AI gợi ý |
| `hint_bulb.svg` | **Hint Bulb** | Nút gợi ý loại trừ phương án sai |
| `bookmark_flag.svg` | **Bookmark Flag** | Đánh dấu câu hỏi khó để xem lại trước khi nộp bài |
| `trophy_cup.svg` | **Trophy Cup** | Huy hiệu hoàn thành xuất sắc / Thăng hạng Leaderboard |
| `check_correct.svg`| **Correct Check** | Phương án trả lời chính xác (Xanh lục `#16A34A`) |
| `cross_incorrect.svg`| **Wrong Cross** | Phương án trả lời sai (Đỏ `#DC2626`) |
| `accuracy_chart.svg`| **Accuracy Chart** | Biểu đồ radar phân tích tỷ lệ chính xác theo chủ đề |
| `code_terminal.svg` | **Code Terminal** | Huy hiệu câu hỏi tình huống lập trình & debug mã nguồn |
| `algorithm_brain.svg`| **Algorithm Brain**| Danh mục thuật toán, cấu trúc dữ liệu và tư duy logic |
| `database_storage.svg`| **Database Storage**| Danh mục backend, SQL/NoSQL và lưu trữ dữ liệu |

---

## 5. Quy Chuẩn Thành Phần Màn Hình Làm Bài (Quiz Component Blueprints)

### 5.1. Sticky Glassy Quiz Header
- **Chiều cao:** 64dp
- **Hiệu ứng:** Glassmorphism Backdrop Filter (Blur 16px, background `#F7F8F9` opacity 0.88).
- **Cấu trúc:**
  - Nút Thoát bài thi (`Icons.arrow_back` hoặc `Icons.close`) có hộp thoại xác nhận nếu bài thi đang diễn ra.
  - Bộ đếm tiến độ: Text `Câu 3/10` kết hợp `LinearProgressIndicator` (chiều cao 6dp, bo góc 3dp, màu `#2ACDC1`).
  - Timer Widget: Icon `quiz_timer.svg` + Text đếm ngược mm:ss. Khi $\le 60$s, đổi màu sang `#F59E0B` và rung nhẹ.

### 5.2. Question Card & Code Snippet
- **Card Background:** `#FFFFFF`
- **Border:** 1.5px `#D8EEE9`
- **Border Radius:** 16px
- **Box Shadow:** `0 8px 24px rgba(0, 141, 128, 0.06)`
- **Code Snippet Container:**
  - Background: `#1E293B` (Dark slate theme để làm nổi bật code màu)
  - Padding: 14dp
  - Bo góc: 10px
  - Font: Fira Code hoặc Roboto Mono (kích thước 13px, line-height 1.5)

### 5.3. Option Selector (4 Trạng Thái Tương Tác)
Mỗi phương án trắc nghiệm là một Card độc lập có chiều cao tối thiểu 56dp:

```
[A]  Default State       --> Viền #E2E2E2, Nền #FFFFFF, Text #1A1C1C
[B]  Selected State      --> Viền 2px #2ACDC1, Nền #E3F8F5, Text #008D80, Radio Teal
[C]  Correct State       --> Viền 2px #16A34A, Nền #DCFCE7, Text #15803D, Icon check_correct
[D]  Incorrect State     --> Viền 2px #DC2626, Nền #FEE2E2, Text #B91C1C, Icon cross_incorrect
```

### 5.4. Floating AI Tutor Pill & Bottom Sheet
- Nút bấm dạng Capsule trôi nổi hoặc gắn cạnh câu hỏi:
  - Icon `ai_sparkle.svg` + Text `"AI Giải thích"`
  - Background: Gradient `LinearGradient(colors: [#2ACDC1, #008D80])`
  - Đổ bóng: `0 4px 14px rgba(42, 205, 193, 0.4)`
- **Bottom Sheet Giải Thích:**
  - Bo góc trên 24px.
  - Phân tích đa tầng:
    1. *Tại sao phương án này tối ưu?*
    2. *Lỗi sai thường gặp ở các phương án còn lại.*
    3. *Đoạn mã mẫu (Clean Code Example).*

### 5.5. Quiz Result Screen & Gamification
- **Vòng tròn điểm số (Score Donut):** Tỷ lệ phần trăm đúng kết hợp Animation xoay.
- **Thống kê chi tiết (Stat Grid):**
  - Thời gian hoàn thành (Average time per question).
  - Chuỗi đúng cao nhất (`streak_flame.svg`).
  - Điểm thưởng xếp hạng (`trophy_cup.svg`).
- **CTA Nổi Bật (Adaptive Next Step):**
  - `"✨ Luyện lại các câu làm sai với AI Tutor"`
  - `"Bảng xếp hạng tuần"`

---

## 6. Grid, Spacing & Motion Specs

### 6.1. Spacing Scale (8pt System)
- `AppSpacing.xs`: 4dp (Khoảng cách icon và text nội bộ)
- `AppSpacing.sm`: 8dp (Khoảng cách giữa các chip, padding nhỏ)
- `AppSpacing.md`: 12dp (Padding các thành phần con)
- `AppSpacing.lg`: 16dp (Padding chuẩn trong card, khoảng cách giữa các option)
- `AppSpacing.xl`: 20dp (Khoảng cách giữa các khối lớn)
- `AppSpacing.xxl`: 24dp (Padding lề màn hình trái/phải)
- `AppSpacing.huge`: 32dp (Khoảng cách tiêu đề và nội dung)

### 6.2. Animation & Transition Curves
- **Thời gian chuyển câu hỏi:** 250ms (`Curves.easeInOutCubic`).
- **Hiệu ứng chọn phương án:** Scale 0.98 $\rightarrow$ 1.0 (150ms).
- **Timer Pulse khi gần hết giờ:** 1000ms Loop (`Curves.fastOutSlowIn`).

---

## 7. Stitch & Figma Prompt Template (Dành cho AI UI Generation)

Khi dùng công cụ Stitch MCP hoặc sinh màn hình Figma, sử dụng prompt mẫu sau:

```text
Design a modern mobile quiz screen for DevMind AI in Flutter.
Color palette:
- Primary: #2ACDC1 (Teal)
- Primary Dark: #008D80 (Deep Teal)
- Background: #F9F9F9 (Subtle off-white)
- Card Surface: #FFFFFF with soft border #D8EEE9 and glassy drop shadow
- Typography: Plus Jakarta Sans, high readability

Elements:
1. Glassy top bar with progress bar (3/10 questions) and circular countdown timer with quiz_timer icon.
2. Question card containing a technical interview scenario with a dark syntax-highlighted code snippet (#1E293B background).
3. Four vertical option cards with states: default (#FFFFFF), selected (#E3F8F5 with #2ACDC1 border), correct (#16A34A), incorrect (#DC2626).
4. Floating AI Tutor button with ai_sparkle icon and gradient teal background.
5. Bottom action bar with 'Next Question' button in ergonomic thumb zone.
```
