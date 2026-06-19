const questions = [
  // ===== FLUTTER & DART =====
  {
    question: 'Trong Flutter, sự khác biệt chính giữa StatelessWidget và StatefulWidget là gì?',
    options: [
      'StatelessWidget nhanh hơn StatefulWidget',
      'StatefulWidget có thể thay đổi nội dung sau khi được render, StatelessWidget thì không',
      'StatelessWidget chỉ dùng cho UI đơn giản, StatefulWidget cho UI phức tạp',
      'Không có sự khác biệt nào đáng kể',
    ],
    correctAnswer: 1,
    explanation:
      'StatefulWidget có một đối tượng State đi kèm, có thể gọi setState() để kích hoạt rebuild UI khi dữ liệu thay đổi. StatelessWidget không có state nội tại — chỉ phụ thuộc vào props đầu vào.',
    category: 'flutter_dart',
    difficulty: 'easy',
  },
  {
    question: 'Trong Dart, sự khác biệt giữa `final` và `const` là gì?',
    options: [
      '`final` là compile-time constant, `const` là runtime constant',
      '`const` là compile-time constant, `final` chỉ gán một lần nhưng có thể là runtime value',
      '`final` và `const` hoàn toàn giống nhau',
      '`const` chỉ dùng được với kiểu số nguyên',
    ],
    correctAnswer: 1,
    explanation:
      '`const` yêu cầu giá trị phải biết tại thời điểm compile. `final` chỉ yêu cầu gán một lần — giá trị có thể được tính tại runtime (ví dụ: `final now = DateTime.now()`).',
    category: 'flutter_dart',
    difficulty: 'medium',
  },
  {
    question: 'Widget `FutureBuilder` trong Flutter được dùng để làm gì?',
    options: [
      'Tạo animation theo thời gian thực',
      'Build UI dựa trên trạng thái của một Future (đang chờ, thành công, lỗi)',
      'Xây dựng danh sách cuộn vô hạn',
      'Quản lý navigation giữa các màn hình',
    ],
    correctAnswer: 1,
    explanation:
      'FutureBuilder nhận một Future và builder callback. Nó tự động rebuild UI khi Future chuyển sang trạng thái waiting, done (data), hoặc done (error), rất hữu ích khi fetch dữ liệu từ API.',
    category: 'flutter_dart',
    difficulty: 'medium',
  },
  {
    question: 'Trong Flutter, `BuildContext` là gì và tại sao nó quan trọng?',
    options: [
      'Là một class chứa toàn bộ màu sắc của ứng dụng',
      'Là handle đại diện cho vị trí của một widget trong cây widget, dùng để truy cập thông tin từ widget cha',
      'Là đối tượng quản lý vòng đời của màn hình',
      'Là wrapper bao ngoài mỗi StatefulWidget',
    ],
    correctAnswer: 1,
    explanation:
      'BuildContext đại diện cho vị trí của widget trong cây widget. Qua đó bạn có thể truy cập Theme, MediaQuery, Navigator, Provider, v.v. từ widget cha. Dùng context sai luồng (sau async gap) là lỗi phổ biến.',
    category: 'flutter_dart',
    difficulty: 'hard',
  },
  {
    question: 'Trong Dart, từ khóa `async*` và `yield` được dùng để tạo ra gì?',
    options: [
      'Một Future trả về nhiều giá trị',
      'Một Stream phát ra nhiều giá trị theo thời gian',
      'Một Generator function đồng bộ',
      'Một Completer để quản lý async',
    ],
    correctAnswer: 1,
    explanation:
      '`async*` biến một hàm thành một Stream generator. Mỗi lần gọi `yield value`, một giá trị được phát ra qua Stream. Phù hợp để tạo luồng dữ liệu theo thời gian như polling API hay đọc file theo chunk.',
    category: 'flutter_dart',
    difficulty: 'hard',
  },
  {
    question: 'Phương thức `dispose()` trong Flutter được gọi khi nào và dùng để làm gì?',
    options: [
      'Được gọi mỗi khi widget rebuild, dùng để reset state',
      'Được gọi khi State bị xóa khỏi cây widget, dùng để giải phóng tài nguyên như controllers hay subscriptions',
      'Được gọi trước `initState()` để chuẩn bị tài nguyên',
      'Được gọi khi ứng dụng bị tắt hoàn toàn',
    ],
    correctAnswer: 1,
    explanation:
      '`dispose()` là phương thức lifecycle được gọi khi State bị remove khỏi cây widget vĩnh viễn. Bạn nên gọi `.dispose()` trên các AnimationController, TextEditingController, StreamSubscription tại đây để tránh memory leak.',
    category: 'flutter_dart',
    difficulty: 'medium',
  },

  // ===== JAVASCRIPT =====
  {
    question: 'Trong JavaScript, `Promise.all()` và `Promise.allSettled()` khác nhau như thế nào?',
    options: [
      'Không có sự khác biệt, cả hai đều chờ tất cả promises hoàn thành',
      '`Promise.all()` reject ngay khi có 1 promise thất bại; `Promise.allSettled()` luôn chờ tất cả và trả về kết quả từng promise',
      '`Promise.allSettled()` nhanh hơn vì không cần chờ tất cả',
      '`Promise.all()` dùng cho async/await còn `Promise.allSettled()` dùng cho callback',
    ],
    correctAnswer: 1,
    explanation:
      '`Promise.all()` fail-fast — reject ngay khi bất kỳ promise nào reject. `Promise.allSettled()` luôn resolve sau khi tất cả promises kết thúc (dù thành công hay thất bại), trả về mảng `{status, value/reason}`. Dùng khi bạn cần xử lý cả success lẫn failure của từng promise.',
    category: 'javascript',
    difficulty: 'medium',
  },
  {
    question: 'Đoạn code sau output gì?\n```js\nconsole.log(typeof null);\nconsole.log(null instanceof Object);\n```',
    options: [
      '"null" và true',
      '"object" và false',
      '"object" và true',
      '"undefined" và false',
    ],
    correctAnswer: 1,
    explanation:
      '`typeof null` trả về `"object"` — đây là bug lịch sử của JS từ phiên bản đầu tiên (năm 1995) và không thể sửa vì sẽ phá vỡ backward compatibility. Tuy nhiên `null instanceof Object` trả về `false` vì null không phải là instance của bất kỳ constructor nào.',
    category: 'javascript',
    difficulty: 'medium',
  },
  {
    question: 'Closure trong JavaScript là gì?',
    options: [
      'Một cú pháp để đóng gói code trong block {}',
      'Khả năng một hàm con ghi nhớ và truy cập biến từ scope của hàm cha, ngay cả sau khi hàm cha đã kết thúc',
      'Một cách để private hóa class trong ES6',
      'Toán tử tắt một Promise đang chạy',
    ],
    correctAnswer: 1,
    explanation:
      'Closure là khi một hàm "nhớ" môi trường lexical nơi nó được khai báo. Ví dụ: hàm counter trả về một hàm increment — hàm increment closure over biến `count` của hàm cha dù hàm cha đã return. Closure là nền tảng của module pattern, memoization, và nhiều pattern quan trọng khác trong JS.',
    category: 'javascript',
    difficulty: 'medium',
  },
  {
    question: 'Kết quả của `0.1 + 0.2 === 0.3` trong JavaScript là gì và tại sao?',
    options: [
      'true — vì phép cộng số học cơ bản',
      'false — vì JavaScript dùng IEEE 754 floating-point, gây ra lỗi làm tròn nhỏ',
      'undefined — vì JS không hỗ trợ so sánh số thực',
      'Lỗi TypeError',
    ],
    correctAnswer: 1,
    explanation:
      'JavaScript dùng IEEE 754 double-precision floating-point. `0.1 + 0.2` thực ra là `0.30000000000000004` do cách biểu diễn nhị phân của số thập phân. Để so sánh số thực, dùng `Math.abs(a - b) < Number.EPSILON` hoặc thư viện `Decimal.js`.',
    category: 'javascript',
    difficulty: 'hard',
  },
  {
    question: 'Sự khác biệt giữa `==` và `===` trong JavaScript là gì?',
    options: [
      '`===` nhanh hơn `==` trong quá trình so sánh',
      '`==` so sánh giá trị sau khi type coercion (ép kiểu); `===` so sánh cả giá trị lẫn kiểu dữ liệu',
      '`==` chỉ dùng cho số, `===` dùng cho string',
      'Không có sự khác biệt trong ES6 trở lên',
    ],
    correctAnswer: 1,
    explanation:
      '`==` thực hiện type coercion: `"5" == 5` là `true`, `null == undefined` là `true`, `false == 0` là `true`. `===` (strict equality) không ép kiểu: `"5" === 5` là `false`. Hầu hết style guides (Airbnb, Google) khuyến nghị luôn dùng `===`.',
    category: 'javascript',
    difficulty: 'easy',
  },

  // ===== REACT =====
  {
    question: 'Tại sao không nên gọi Hooks trong vòng lặp, điều kiện, hay hàm lồng nhau trong React?',
    options: [
      'Vì Hooks không hỗ trợ cú pháp này',
      'Vì React dựa vào thứ tự gọi Hooks để liên kết state và effect với đúng hook call — thay đổi thứ tự gây ra bugs khó debug',
      'Vì hiệu năng sẽ giảm đáng kể',
      'Vì đây là quy ước đặt tên, không phải giới hạn kỹ thuật',
    ],
    correctAnswer: 1,
    explanation:
      'React lưu trạng thái của Hooks theo thứ tự gọi trong mỗi lần render. Nếu bạn đặt Hook trong `if` block, thứ tự có thể thay đổi giữa các lần render, khiến React liên kết sai state với sai Hook. Đây là "Rules of Hooks" — một trong những nguyên tắc cốt lõi.',
    category: 'react',
    difficulty: 'hard',
  },
  {
    question: 'Trong React, `useCallback` và `useMemo` khác nhau như thế nào?',
    options: [
      'Cả hai đều giống nhau, chỉ khác cú pháp',
      '`useCallback` memoize một hàm, `useMemo` memoize kết quả tính toán (giá trị)',
      '`useMemo` memoize một hàm, `useCallback` memoize giá trị trả về',
      '`useCallback` dùng cho side effects, `useMemo` dùng cho state',
    ],
    correctAnswer: 1,
    explanation:
      '`useCallback(fn, deps)` trả về bản memoized của hàm `fn` — chỉ tạo lại khi deps thay đổi. `useMemo(fn, deps)` gọi `fn()` và memoize kết quả trả về. Dùng `useCallback` khi truyền callback xuống child component để tránh re-render không cần thiết, `useMemo` khi tính toán nặng.',
    category: 'react',
    difficulty: 'hard',
  },
  {
    question: 'React Context API phù hợp nhất cho trường hợp nào sau đây?',
    options: [
      'Quản lý state phức tạp với nhiều action',
      'Chia sẻ dữ liệu "global" như theme, locale, thông tin user đang đăng nhập mà không cần prop drilling',
      'Fetch và cache dữ liệu từ API',
      'Tối ưu hiệu năng render của danh sách lớn',
    ],
    correctAnswer: 1,
    explanation:
      'Context API giải quyết prop drilling — truyền dữ liệu qua nhiều tầng component không cần thiết. Phù hợp cho theme, ngôn ngữ, thông tin auth. Với state phức tạp và thường xuyên thay đổi, nên kết hợp useReducer + Context hoặc dùng thư viện như Zustand, Redux.',
    category: 'react',
    difficulty: 'medium',
  },
  {
    question: 'Tại sao React yêu cầu mỗi phần tử trong danh sách phải có thuộc tính `key` duy nhất?',
    options: [
      'Để đặt tên cho HTML element trong DOM',
      'Để React xác định element nào thay đổi, thêm hoặc xóa trong quá trình reconciliation, giúp tối ưu re-render',
      'Vì đây là cú pháp bắt buộc của JSX',
      'Để hỗ trợ accessibility (ARIA)',
    ],
    correctAnswer: 1,
    explanation:
      'React dùng Virtual DOM diffing (reconciliation). `key` giúp React nhận biết element nào cần update, insert hay remove mà không cần render lại toàn bộ list. Dùng index làm key gây bug khi list có thể reorder — nên dùng ID thực của dữ liệu.',
    category: 'react',
    difficulty: 'easy',
  },

  // ===== PYTHON =====
  {
    question: 'Decorator trong Python là gì?',
    options: [
      'Một cú pháp để trang trí giao diện người dùng',
      'Một hàm nhận một hàm khác làm đối số, mở rộng hành vi của nó mà không thay đổi code gốc',
      'Một annotation để khai báo kiểu dữ liệu',
      'Một class đặc biệt kế thừa từ `object`',
    ],
    correctAnswer: 1,
    explanation:
      'Decorator là higher-order function. Cú pháp `@decorator` tương đương `func = decorator(func)`. Ứng dụng phổ biến: `@property`, `@staticmethod`, `@classmethod`, logging, authentication check, caching (`@functools.lru_cache`), retry logic.',
    category: 'python',
    difficulty: 'medium',
  },
  {
    question: 'Sự khác biệt giữa List và Tuple trong Python là gì?',
    options: [
      'Tuple nhanh hơn và tiêu tốn ít bộ nhớ hơn vì immutable; List có thể thay đổi (mutable)',
      'List dùng cho số, Tuple dùng cho chuỗi ký tự',
      'Tuple có thể chứa nhiều phần tử hơn List',
      'Không có sự khác biệt thực tế',
    ],
    correctAnswer: 0,
    explanation:
      'Tuple là immutable (không thể thay đổi sau khi tạo), vì vậy Python có thể tối ưu bộ nhớ và tốc độ truy cập. Tuple phù hợp làm dictionary key (vì hashable), trả về nhiều giá trị từ hàm, hoặc dữ liệu cố định. List phù hợp khi cần thêm/xóa/sửa phần tử.',
    category: 'python',
    difficulty: 'easy',
  },
  {
    question: 'Generator expression trong Python (`(x*2 for x in range(1000))`) có ưu điểm gì so với list comprehension (`[x*2 for x in range(1000)]`)?',
    options: [
      'Generator nhanh hơn khi cần truy cập ngẫu nhiên theo index',
      'Generator tiêu tốn ít bộ nhớ hơn vì tính toán "lazy" — chỉ tạo giá trị khi cần, không lưu toàn bộ vào RAM',
      'Generator có thể chứa nhiều phần tử hơn',
      'List comprehension không hỗ trợ `range()` lớn',
    ],
    correctAnswer: 1,
    explanation:
      'List comprehension tạo toàn bộ danh sách trong RAM ngay lập tức. Generator là lazy iterator — chỉ tính toán giá trị tiếp theo khi được yêu cầu. Khi xử lý 1 triệu dòng file, generator dùng O(1) bộ nhớ thay vì O(n). Dùng `next()` hoặc vòng lặp `for` để lấy giá trị.',
    category: 'python',
    difficulty: 'medium',
  },
  {
    question: 'Trong Python, `*args` và `**kwargs` trong định nghĩa hàm có nghĩa là gì?',
    options: [
      '`*args` nhận danh sách cố định, `**kwargs` nhận dictionary cố định',
      '`*args` nhận số lượng tham số positional tùy ý thành tuple; `**kwargs` nhận số lượng keyword arguments tùy ý thành dict',
      '`*args` dành cho số, `**kwargs` dành cho chuỗi',
      'Cả hai đều giống nhau, chỉ khác cú pháp',
    ],
    correctAnswer: 1,
    explanation:
      '`*args` ("arguments") pack các positional args thành tuple. `**kwargs` ("keyword arguments") pack các named args thành dict. Ví dụ: `def func(*args, **kwargs)` có thể gọi bằng `func(1, 2, x=3, y=4)` — args=(1,2), kwargs={"x":3,"y":4}. Rất hữu ích khi viết wrapper functions hoặc decorator.',
    category: 'python',
    difficulty: 'medium',
  },

  // ===== SQL & DATABASE =====
  {
    question: 'Sự khác biệt giữa `INNER JOIN` và `LEFT JOIN` trong SQL là gì?',
    options: [
      '`INNER JOIN` nhanh hơn `LEFT JOIN` trong mọi trường hợp',
      '`INNER JOIN` chỉ trả về hàng có dữ liệu khớp ở cả hai bảng; `LEFT JOIN` trả về tất cả hàng của bảng trái, NULL ở cột bảng phải nếu không khớp',
      '`LEFT JOIN` chỉ dùng được với bảng có ít hơn 1000 hàng',
      'Không có sự khác biệt về kết quả, chỉ khác cú pháp',
    ],
    correctAnswer: 1,
    explanation:
      '`INNER JOIN` loại bỏ hàng không có pair ở bảng kia. `LEFT JOIN` (hay LEFT OUTER JOIN) giữ lại tất cả hàng của bảng bên trái, điền NULL vào cột bảng phải khi không tìm được match. Tương tự, `RIGHT JOIN` giữ bảng phải, `FULL OUTER JOIN` giữ tất cả.',
    category: 'sql_database',
    difficulty: 'easy',
  },
  {
    question: 'Index trong database giải quyết vấn đề gì và có nhược điểm gì?',
    options: [
      'Index tăng tốc mọi thao tác đọc/ghi, không có nhược điểm',
      'Index tăng tốc câu truy vấn SELECT/WHERE, nhưng làm chậm INSERT/UPDATE/DELETE và tốn thêm bộ nhớ lưu trữ',
      'Index chỉ có tác dụng với bảng có hơn 1 triệu hàng',
      'Index thay thế cho việc dùng WHERE clause',
    ],
    correctAnswer: 1,
    explanation:
      'Index tạo cấu trúc dữ liệu phụ (thường là B-tree) để tăng tốc tìm kiếm — tương tự mục lục sách. Trade-off: mỗi INSERT/UPDATE/DELETE phải cập nhật cả index, tốn thêm I/O và storage. Nên index những cột thường xuất hiện trong WHERE, JOIN ON, ORDER BY. Quá nhiều index làm chậm write-heavy workload.',
    category: 'sql_database',
    difficulty: 'medium',
  },
  {
    question: 'Khi nào nên dùng NoSQL (như MongoDB, Firebase) thay vì SQL (như PostgreSQL)?',
    options: [
      'NoSQL luôn tốt hơn SQL vì hiệu năng cao hơn',
      'NoSQL phù hợp khi schema linh hoạt/thay đổi thường xuyên, dữ liệu dạng document/graph/key-value, cần scale horizontal dễ dàng; SQL phù hợp khi cần ACID transactions và quan hệ phức tạp giữa các bảng',
      'NoSQL chỉ dùng cho mobile apps, SQL dùng cho web apps',
      'SQL không hỗ trợ dữ liệu JSON',
    ],
    correctAnswer: 1,
    explanation:
      'Không có silver bullet. NoSQL (document store như Firestore) phù hợp: schema chưa ổn định, dữ liệu lồng nhau tự nhiên, cần horizontal scaling. SQL phù hợp: quan hệ nhiều-nhiều phức tạp, cần ACID transactions mạnh (ngân hàng, tài chính), reporting và analytics. Nhiều hệ thống hiện đại dùng cả hai (polyglot persistence).',
    category: 'sql_database',
    difficulty: 'medium',
  },

  // ===== GIT & DEVOPS =====
  {
    question: 'Sự khác biệt giữa `git merge` và `git rebase` là gì?',
    options: [
      'Cả hai đều giống nhau, chỉ khác tên lệnh',
      '`git merge` giữ nguyên lịch sử commit (tạo merge commit); `git rebase` viết lại lịch sử bằng cách chuyển commits lên đầu branch target, tạo lịch sử tuyến tính',
      '`git rebase` an toàn hơn để dùng trên branch chính (main/master)',
      '`git merge` chỉ dùng được với nhánh local',
    ],
    correctAnswer: 1,
    explanation:
      '`merge` tạo merge commit, bảo toàn lịch sử thật nhưng có thể phức tạp. `rebase` "replay" các commits của bạn lên trên branch target — lịch sử sạch và tuyến tính nhưng rewrites commit hashes. Golden rule: **không rebase trên branch đã push public** vì gây conflict cho người khác. Dùng rebase cho feature branches local, merge cho main.',
    category: 'git_devops',
    difficulty: 'medium',
  },
  {
    question: 'CI/CD là gì và lợi ích chính của nó là gì?',
    options: [
      'Một ngôn ngữ lập trình mới cho DevOps',
      'Continuous Integration (tự động build và test khi push code) và Continuous Delivery/Deployment (tự động deploy) — giảm rủi ro, phát hiện lỗi sớm, rút ngắn chu kỳ release',
      'Một tool thay thế cho Docker',
      'Chỉ là cách đặt tên cho unit testing',
    ],
    correctAnswer: 1,
    explanation:
      'CI (Continuous Integration): dev merge code thường xuyên, trigger tự động build + test (unit, integration). CD (Continuous Delivery): tự động chuẩn bị bản release, cần approve thủ công; Continuous Deployment: tự động deploy thẳng lên production. Tools phổ biến: GitHub Actions, GitLab CI, Jenkins, CircleCI.',
    category: 'git_devops',
    difficulty: 'easy',
  },

  // ===== DATA STRUCTURES & ALGORITHMS =====
  {
    question: 'Độ phức tạp thời gian của Binary Search là bao nhiêu và yêu cầu gì với dữ liệu đầu vào?',
    options: [
      'O(n) — không yêu cầu gì đặc biệt',
      'O(log n) — yêu cầu mảng đã được sắp xếp',
      'O(n log n) — yêu cầu hash map',
      'O(1) — chỉ dùng cho mảng nhỏ',
    ],
    correctAnswer: 1,
    explanation:
      'Binary Search hoạt động bằng cách liên tục chia đôi không gian tìm kiếm. Mỗi bước loại bỏ một nửa phần tử còn lại. Với mảng 1 triệu phần tử, chỉ cần tối đa 20 bước (log₂(1,000,000) ≈ 20). Điều kiện bắt buộc: mảng phải được sắp xếp trước. Nếu dữ liệu không sorted, dùng hash map cho O(1) lookup.',
    category: 'data_structures',
    difficulty: 'easy',
  },
  {
    question: 'Stack và Queue khác nhau như thế nào? Mỗi loại phù hợp dùng khi nào?',
    options: [
      'Stack và Queue đều là cấu trúc FIFO, không có sự khác biệt',
      'Stack là LIFO (Last In First Out) — phù hợp cho undo/redo, call stack, DFS; Queue là FIFO (First In First Out) — phù hợp cho BFS, hàng đợi task, message queue',
      'Stack chỉ dùng cho số nguyên, Queue dùng cho chuỗi',
      'Queue nhanh hơn Stack trong mọi thao tác',
    ],
    correctAnswer: 1,
    explanation:
      'Stack (LIFO): element cuối vào, đầu tiên ra. Ứng dụng: function call stack, browser back button, balanced brackets checker, undo. Queue (FIFO): element đầu vào, đầu tiên ra. Ứng dụng: BFS graph traversal, printer queue, background job processing, message brokers (Kafka, RabbitMQ).',
    category: 'data_structures',
    difficulty: 'easy',
  },
  {
    question: 'Tại sao HashMap (HashTable) thường cho O(1) lookup nhưng đôi khi là O(n)?',
    options: [
      'HashMap luôn đảm bảo O(1), không bao giờ O(n)',
      'Trong trường hợp bình thường, hash function phân phối keys đều → O(1). Nhưng khi xảy ra nhiều hash collision, nhiều keys cùng bucket → worst case O(n)',
      'O(n) xảy ra khi HashMap vượt quá 1000 phần tử',
      'HashMap không phải O(1), mà luôn là O(log n)',
    ],
    correctAnswer: 1,
    explanation:
      'HashMap hash key thành index → truy cập bucket trực tiếp → O(1) average. Hash collision: nhiều keys ra cùng hash value → cùng bucket → cần duyệt linked list trong bucket → O(n) worst case. Giải pháp: hash function tốt, load factor phù hợp, rehashing khi bảng đầy. Java HashMap, Python dict dùng open addressing để giảm collision.',
    category: 'data_structures',
    difficulty: 'hard',
  },

  // ===== SYSTEM DESIGN =====
  {
    question: 'REST API và GraphQL khác nhau như thế nào?',
    options: [
      'GraphQL chỉ dùng GET request, REST dùng tất cả HTTP methods',
      'REST có nhiều endpoints cố định, mỗi endpoint trả về cấu trúc data cố định; GraphQL có một endpoint duy nhất, client chỉ định chính xác data cần lấy, tránh over-fetching và under-fetching',
      'GraphQL nhanh hơn REST trong mọi trường hợp',
      'REST không hỗ trợ authentication',
    ],
    correctAnswer: 1,
    explanation:
      'REST: mỗi resource có URL riêng (/users, /posts). Client nhận toàn bộ data của endpoint dù chỉ cần một phần (over-fetching), hoặc phải gọi nhiều endpoints (under-fetching). GraphQL: một POST endpoint /graphql, client dùng query language để yêu cầu đúng fields cần. Trade-off: GraphQL phức tạp hơn phía server (resolver, N+1 problem cần DataLoader).',
    category: 'system_design',
    difficulty: 'medium',
  },
  {
    question: 'Caching thường được đặt ở những lớp nào trong kiến trúc hệ thống và lợi ích là gì?',
    options: [
      'Caching chỉ đặt ở database layer',
      'CDN (static assets), Browser cache, API Gateway cache, Application cache (Redis/Memcached), Database query cache — giảm latency, giảm tải cho backend và database',
      'Caching chỉ phù hợp cho ứng dụng có hơn 1 triệu user',
      'Caching làm tăng complexity mà không mang lại lợi ích đáng kể',
    ],
    correctAnswer: 1,
    explanation:
      'Caching là một trong những kỹ thuật tối ưu hiệu năng quan trọng nhất: CDN cache static files gần user địa lý, Browser cache giảm request, Redis cache query results tốn kém, giảm load DB. Trade-off cần cân nhắc: cache invalidation (stale data), cache stampede, eviction policy (LRU, LFU). "There are only two hard things in Computer Science: cache invalidation and naming things." — Phil Karlton.',
    category: 'system_design',
    difficulty: 'medium',
  },

  // ===== OBJECT-ORIENTED PROGRAMMING =====
  {
    question: 'SOLID trong lập trình OOP gồm những nguyên tắc nào?',
    options: [
      'Single/Open/Liskov/Interface/Dependency — 5 nguyên tắc thiết kế giúp code dễ maintain, extend và test',
      'Security/Optimization/Logic/Integration/Deployment',
      'SOLID là tên một design pattern cụ thể',
      'SOLID chỉ áp dụng cho Java, không áp dụng cho ngôn ngữ khác',
    ],
    correctAnswer: 0,
    explanation:
      'S — Single Responsibility: mỗi class chỉ có một lý do để thay đổi. O — Open/Closed: mở để extend, đóng để modify. L — Liskov Substitution: subclass phải thay thế được superclass. I — Interface Segregation: nhiều interface nhỏ tốt hơn một interface lớn. D — Dependency Inversion: depend on abstractions, not concretions. Đây là nền tảng của clean architecture.',
    category: 'oop_concepts',
    difficulty: 'medium',
  },
  {
    question: 'Composition vs Inheritance — khi nào nên dùng Composition thay vì kế thừa (Inheritance)?',
    options: [
      'Luôn dùng Inheritance vì đó là nguyên lý cơ bản của OOP',
      'Dùng Composition ("has-a" relationship) khi muốn tái sử dụng hành vi linh hoạt; Inheritance ("is-a") khi có quan hệ phân cấp tự nhiên. "Favor composition over inheritance" là nguyên tắc phổ biến',
      'Composition chỉ dùng được trong functional programming',
      'Inheritance luôn có hiệu năng tốt hơn Composition',
    ],
    correctAnswer: 1,
    explanation:
      '"Favor composition over inheritance" (GoF Design Patterns). Inheritance tạo coupling chặt — thay đổi parent class ảnh hưởng toàn bộ hierarchy. Composition linh hoạt hơn: inject behavior qua constructor/setter, dễ test (mock dependencies), dễ thay đổi behavior lúc runtime. Ví dụ: thay vì `Dog extends Animal extends LivingThing`, dùng `Dog` có `MovementBehavior`, `SoundBehavior` dạng interface.',
    category: 'oop_concepts',
    difficulty: 'hard',
  },

  // ===== NETWORKING =====
  {
    question: 'HTTPS khác HTTP như thế nào và TLS handshake diễn ra như thế nào?',
    options: [
      'HTTPS chỉ là HTTP với tốc độ nhanh hơn',
      'HTTPS mã hóa traffic qua TLS/SSL. Handshake: client gửi supported cipher suites → server gửi certificate + public key → client verify cert → trao đổi session key → mã hóa đối xứng cho phần còn lại',
      'HTTPS yêu cầu VPN mới hoạt động được',
      'TLS và SSL là hai giao thức hoàn toàn khác nhau không liên quan',
    ],
    correctAnswer: 1,
    explanation:
      'HTTP truyền data dạng plain text — ai nghe lén đều đọc được. HTTPS = HTTP + TLS. TLS handshake dùng asymmetric crypto (RSA/EC) để trao đổi session key an toàn, sau đó dùng symmetric encryption (AES) cho data thực (nhanh hơn nhiều). Certificate Authorities (CA) xác thực server identity. TLS 1.3 (2018) rút ngắn handshake xuống còn 1-RTT.',
    category: 'networking',
    difficulty: 'hard',
  },
  {
    question: 'HTTP status code 401 và 403 khác nhau như thế nào?',
    options: [
      'Cả hai đều nghĩa là "Not Found"',
      '401 Unauthorized: chưa xác thực (cần đăng nhập); 403 Forbidden: đã xác thực nhưng không có quyền truy cập resource đó',
      '403 là lỗi server, 401 là lỗi client',
      '401 dùng cho REST API, 403 dùng cho website thông thường',
    ],
    correctAnswer: 1,
    explanation:
      '401 (Unauthorized, nhưng thực ra nghĩa là "Unauthenticated"): bạn chưa cung cấp credential hoặc credential không hợp lệ. Response nên có `WWW-Authenticate` header. 403 (Forbidden): server biết bạn là ai nhưng từ chối quyền truy cập. Ví dụ: user thường cố truy cập trang admin → 403. Chưa login → 401.',
    category: 'networking',
    difficulty: 'easy',
  },
];

questions.forEach((q) => {
  if (!q.createdAt) {
    q.createdAt = new Date().toISOString();
  }
});

module.exports = questions;