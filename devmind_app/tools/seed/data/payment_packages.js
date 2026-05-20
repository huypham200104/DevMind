const paymentPackages = [
  {
    name: 'Gói Cơ Bản (Giải thích)',
    description: 'Mua thêm 10 lượt giải thích câu hỏi kỹ thuật / IQ.',
    price: 10000,
    creditType: 'explanation',
    creditAmount: 10,
    isPopular: false,
    createdAt: new Date(),
  },
  {
    name: 'Gói Phổ Biến (Giải thích)',
    description: 'Mua thêm 30 lượt giải thích câu hỏi kỹ thuật / IQ. Tiết kiệm 15%.',
    price: 25000,
    creditType: 'explanation',
    creditAmount: 30,
    isPopular: true,
    createdAt: new Date(),
  },
  {
    name: 'Gói Chuyên Gia (Giải thích)',
    description: 'Mua thêm 100 lượt giải thích. Dành cho người luyện tập cường độ cao.',
    price: 80000,
    creditType: 'explanation',
    creditAmount: 100,
    isPopular: false,
    createdAt: new Date(),
  },
  {
    name: 'Gói Cơ Bản (Quét CV)',
    description: 'Mua thêm 3 lượt quét và nhận xét CV bằng AI.',
    price: 10000,
    creditType: 'cv_scan',
    creditAmount: 3,
    isPopular: false,
    createdAt: new Date(),
  },
  {
    name: 'Gói Nâng Cao (Quét CV)',
    description: 'Mua thêm 10 lượt quét CV. Lý tưởng cho mùa rải CV.',
    price: 30000,
    creditType: 'cv_scan',
    creditAmount: 10,
    isPopular: true,
    createdAt: new Date(),
  },
  {
    name: 'Gói Vô Hạn (Quét CV)',
    description: 'Mua thêm 50 lượt quét CV. Dành cho người chuyên săn việc.',
    price: 100000,
    creditType: 'cv_scan',
    creditAmount: 50,
    isPopular: false,
    createdAt: new Date(),
  }
];

module.exports = paymentPackages;
