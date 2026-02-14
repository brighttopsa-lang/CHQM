# خطة تنفيذ تطبيق Flutter لشركة تدريب (Android + iOS)

> وثيقة عملية لتحويل رحلة المتدرب كاملة من التسجيل حتى الشهادة إلى منتج قابل للإطلاق.

## 1) الهدف والنطاق (Scope)

### الهدف الأساسي
- عرض برامج/شهادات المعهد.
- تسجيل المتدرب وإنشاء الحساب.
- حجز كورس/برنامج (Online / Onsite).
- الدفع/الفاتورة (اختياري حسب سياسة التشغيل).
- دخول الامتحان.
- إظهار النتيجة.
- إصدار شهادة PDF وإرسالها وحفظها داخل الحساب.
- تتبع الشحن (إن وُجد شحن للشهادات الأصلية).

### خارج النطاق في النسخة الأولى (لتسريع الإطلاق)
- LMS كامل (فيديوهات/واجبات/SCORM).
- ميزات AI والتوصيات الذكية.

**مخرج المرحلة:**
- وثيقة صفحة واحدة بعنوان: **What we build / What we don’t build**.

---

## 2) الأدوار والصلاحيات (Roles & Permissions)

1. **Trainee (متدرب)**
   - إدارة الحساب والبيانات.
   - متابعة التسجيلات والامتحانات والشهادات.

2. **Admin (إدارة)**
   - إدارة الكورسات والأسعار والجداول والدفعات.
   - إدارة الامتحانات وبنك الأسئلة.
   - اعتماد النتائج وإصدار الشهادات.
   - إدارة الشحن والتتبع.

3. **Instructor/Trainer (مدرب)**
   - الحضور/التقييم (حسب الحاجة).
   - رفع المواد (إن كانت ضمن النطاق).
   - تقارير تشغيلية بسيطة.

**مخرج المرحلة:**
- جدول واضح: **Role → Permissions**.

---

## 3) رحلة المستخدم (User Journey)

### A) رحلة المتدرب
1. فتح التطبيق → استعراض البرامج (بحث/فلترة).
2. اختيار شهادة (مثل CPPX) → عرض التفاصيل والمواعيد.
3. تسجيل جديد / تسجيل دخول.
4. استكمال البيانات (اسم، هوية، بريد، دولة...).
5. حجز مقعد ضمن دفعة/جلسة.
6. استلام تأكيد وتعليمات.
7. يوم الامتحان: بدء الامتحان.
8. إنهاء الامتحان → رسالة انتظار النتيجة.
9. وصول النتيجة داخل التطبيق + البريد الإلكتروني.
10. تنزيل الشهادة PDF + تحقق QR.
11. (اختياري) إدخال عنوان الشحن ومتابعة الحالة.

### B) رحلة الإدارة
- إنشاء Course + Batch + Exam + Question Bank.
- فتح/إغلاق التسجيل.
- مراجعة حالة الدفع أو ربط الدفع التلقائي.
- اعتماد النتائج.
- توليد الشهادات دفعة واحدة وإرسالها.

**مخرج المرحلة:**
- قائمة Use Cases مرتبة (20–30 حالة).

---

## 4) خريطة الشاشات (UI Map)

### شاشات المتدرب
- Splash / Onboarding
- Home
- Catalog (Search + Filters)
- Course Details
- Login / Register
- Profile
- My Courses
- My Exams
- Exam Instructions
- Exam Screen (MCQ + Timer + Review)
- Result Screen
- My Certificates (PDF + QR)
- Shipping Info (اختياري)
- Notifications

### شاشات الإدارة
- Admin Dashboard
- Manage Courses/Batches
- Manage Exams/Questions
- Trainees & Enrollments
- Results & Approvals
- Certificates Generation
- Shipping Management

> قرار تقني موصى به: **لوحة إدارة Web** (React أو Flutter Web) أفضل غالبًا من إدارة موبايل.

**مخرج المرحلة:**
- Site Map + Wireframes أولية.

---

## 5) نموذج البيانات (Data Model)

### الكيانات الأساسية
- `User(id, name, email, phone, country, role)`
- `Course(id, title, category, description, price, language, duration)`
- `Batch(id, courseId, startDate, sessions, capacity, timezone)`
- `Enrollment(userId, batchId, status, paymentStatus)`
- `Exam(id, courseId, duration, passScore, rules)`
- `Question(id, examId, text, choices[], correctChoice, level, domain)`
- `Attempt(userId, examId, startAt, endAt, score, status)`
- `Certificate(userId, courseId, pdfUrl, qrCode, issueDate, verificationCode)`
- `Shipping(userId, address, status, trackingNumber)`

**مخرج المرحلة:**
- ERD بسيط أو مخطط علاقات واضح.

---

## 6) اختيار الباك-إند (Backend Decision)

### خيار 1: Firebase (MVP سريع)
- Auth + Firestore + Storage + Push.
- مناسب للانطلاق السريع.

### خيار 2: Supabase (SQL قوي)
- Postgres + Auth + Storage.
- ممتاز للتقارير والاستعلامات.

### خيار 3: Backend مخصص (Node/Laravel/Django)
- مرونة كاملة وتكاملات مؤسسية أوسع.

**توصية عملية:**
- MVP: Firebase أو Supabase.
- بيئة تكاملات كبيرة: Backend مخصص + SQL.

**مخرج المرحلة:**
- قرار تقني موثق + أسباب + خطة التكاملات المستقبلية.

---

## 7) قواعد الامتحان والأمان (Exam Security)

- Token لكل Attempt.
- Timer على الخادم + التطبيق.
- خيار منع الرجوع بين الأسئلة.
- Randomization للأسئلة والاختيارات.
- Blueprint لنسب المجالات.
- Anti-cheat خفيف:
  - تسجيل مغادرة الشاشة.
  - تحذير عند تبديل التطبيقات.
  - سياسات قفل/تقييد وفق المنصة.

**مخرج المرحلة:**
- Document لسياسات الامتحان وإعداداته.

---

## 8) الشهادة والتحقق (Certificate + QR)

- قالب PDF ثابت (الاسم، رقم الشهادة، التاريخ، QR).
- QR يفتح صفحة Verify على الموقع.
- الصفحة تعرض: الاسم، الشهادة، تاريخ الإصدار، الحالة (Valid/Revoked).
- عدم تضمين بيانات حساسة داخل QR؛ الاكتفاء بـ verificationCode.

**مخرج المرحلة:**
- Certificate Template + Verification Endpoint Spec.

---

## 9) التكاملات (Integrations)

- Email: SendGrid / SMTP / Gmail API (عبر Backend).
- WhatsApp: Twilio / 360dialog (اختياري).
- Payments: PayPal / Stripe / Tap / Telr.
- Shipping: Aramex / SMSA / DHL API (اختياري).
- Analytics: Firebase Analytics.

**مخرج المرحلة:**
- قائمة APIs + مفاتيح بيئات Dev/Prod.

---

## 10) خارطة التنفيذ (Milestones)

### المرحلة 0: التحضير
- Scope + Roles + UI Map + Data Model + Backend choice.

### المرحلة 1: MVP
- Catalog + Details
- Auth
- Enrollment
- Exam basic (MCQ + Timer)
- Result message

### المرحلة 2: الشهادات
- PDF Generation
- QR Verification Page
- Certificates داخل التطبيق + البريد

### المرحلة 3: التشغيل الكامل
- Admin Panel
- Notifications
- Shipping Module (إن لزم)

### المرحلة 4: تحسينات متقدمة
- Question Blueprint متقدم
- Reports & Dashboards
- Anti-cheat إضافي
- Offline Caching

**مخرج المرحلة:**
- Roadmap + Definition of Done لكل مرحلة.

---

## 11) هيكلة Flutter (Architecture)

1. **Setup**
   - Flutter stable
   - Flavors: dev/prod
   - Env config

2. **State Management**
   - Bloc أو Riverpod
   - Clean Architecture:
     - Presentation
     - Domain
     - Data

3. **Navigation**
   - go_router

4. **Networking**
   - Dio + Interceptors + Refresh Token

5. **Local Storage**
   - Hive / SharedPreferences

6. **Auth & Access Control**
   - Route Guards حسب الدور

7. **Feature Modules**
   - auth
   - catalog
   - enrollment
   - exam
   - certificates
   - profile
   - notifications

**مخرج المرحلة:**
- Folder Structure ثابت للفريق.

---

## 12) الجودة والإطلاق (QA & Release)

- Unit Tests للـ Use Cases.
- Widget Tests للشاشات الحرجة.
- Crash Reporting عبر Crashlytics.
- CI/CD عبر GitHub Actions.
- TestFlight (iOS) + Internal Testing (Android).

**مخرج المرحلة:**
- Release Checklist واضحة للإطلاق.

---

## نسخة مختصرة جاهزة للـ Proposal

**Project Objective:**
Build a cross-platform Flutter mobile application to manage the complete trainee lifecycle: program discovery, registration, enrollment, exam, results, certificate issuance/verification, and optional shipping tracking.

**Key Modules:**
Authentication, Course Catalog, Enrollment, Exam Engine (MCQ), Results, Certificates (PDF + QR verification), Notifications, Profile, and Admin Management (Web Panel preferred).

**Backend:**
Firebase / Supabase / Custom backend with role-based access control, audit logs for attempts, and secure certificate verification endpoint.

**Deliverables:**
UI/UX flows, data model, Flutter source code, backend setup, admin panel, certificate templates, QR verification page, deployment pipeline, and handover documentation.
