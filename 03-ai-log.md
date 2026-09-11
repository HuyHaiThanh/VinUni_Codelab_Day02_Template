# 📝 AI Log & Reflection — Nhật Ký Đồng Hành Cùng AI

> **Học viên:** Duy  
> **Vai trò trong Lab:** AI Product Engineer tại Vin Smart Future  
> **Dự án:** Hệ thống AI Phát hiện Gian lận Cảm biến "Mắt thần" (Xanh SM & VinFast)  
> **Mô hình AI sử dụng làm Thought-Partner:** Google Gemini 2.5 Flash / Claude 3.5 Sonnet  

---

## 1. 🎯 Tổng quan vai trò của AI trong quá trình làm bài

Trong buổi Lab hôm nay, tôi không sử dụng AI như một công cụ "làm bài hộ" (copy-paste thụ động), mà định vị AI như một **Đối tác tư duy phản biện (Thought-Partner / Co-pilot)**. 

Quy trình làm việc diễn ra qua 4 giai đoạn chính:
1. **Brainstorming & Quét bài toán (SCAN):** Nhờ AI quét qua toàn bộ hệ sinh thái các công ty thành viên Vingroup (VinFast, Xanh SM, Vinhomes, Vinmec, Vinpearl) theo khung 4 Lenses.
2. **Xác thực & Thẩm tra dữ liệu (Fact-Checking & Stress-Testing):** Truy vết các vụ án và số liệu thực tế để đảm bảo tính xác thực 100% của bài toán.
3. **Phản biện tính cần thiết của AI (AI vs. Rule-based Debate):** Tự mình đặt câu hỏi chất vấn AI xem bài toán có thực sự cần đến trí tuệ nhân tạo hay chỉ là bài toán rule-based tầm thường.
4. **Thiết lập ranh giới vận hành (Operational Boundaries & Prototyping):** Cùng AI xây dựng kịch bản kiểm thử an toàn (Adversarial Prompts) để bảo vệ hệ thống trước các rủi ro can thiệp vận hành.

---

## 2. 💡 AI đã giúp tôi làm tốt những gì?

* **Gợi ý góc nhìn đa ngành nhanh chóng:** Khi bắt đầu Phase 1, AI đã tổng hợp các quy trình vận hành phức tạp của các công ty thành viên Vingroup, từ quản lý trạm sạc xe điện VinFast, điều vận taxi Xanh SM, đến quy trình xuất viện tại Vinmec.
* **Hỗ trợ cấu trúc hóa bài toán (Structuring):** AI giúp chuẩn hóa bảng mô tả 6 trường (Problem Statement 6-Field) theo đúng quy chuẩn kỹ thuật của Vin Smart Future với đầy đủ: Actor, Current Workflow, Bottlenecks, Business Impact, Success Metrics, và Boundaries.
* **Soạn thảo nhanh các kịch bản kiểm thử tấn công (Adversarial Inputs):** AI đóng vai trò "hacker" rất tốt khi tạo ra các câu lệnh ép buộc hệ thống vượt rào (ví dụ: ép khóa tài khoản tài xế ngay lập tức, ép can thiệp ngắt nguồn xe đang chạy), từ đó giúp tôi hoàn thiện System Prompt chặt chẽ hơn.

---

## 3. ⚠️ Những điểm AI nhầm lẫn, thiếu sót (Hallucination / Gaps) và cách tôi phản biện & sửa lại

Đây là phần giá trị nhất trong quá trình làm việc cùng AI hôm nay. Tôi đã trực tiếp phát hiện và nắn chỉnh 2 thiếu sót nghiêm trọng của mô hình:

### 🔴 Lần 1: AI đưa thông tin thiếu gắn kết với hệ sinh thái Vingroup
* **Tình huống:** Khi AI đề xuất bài toán tài xế taxi dùng thiết bị phát hồng ngoại phá cảm biến "Mắt thần" để chiếm đoạt cước xe, AI chỉ mô tả chung chung về việc tài xế gian lận cước taxi.
* **Tôi chất vấn ngay:** *"Nhưng nó liên quan gì đến Vin?"* và *"Vấn đề là nó đâu có đề cập là hồng ngoại của xe Vin?"*.
* **Vấn đề phát hiện:** AI đưa ra bài toán nhưng không chỉ ra được mối quan hệ sở hữu và công nghệ cốt lõi:
  1. **Xanh SM (GSM)** là Công ty Cổ phần Di chuyển Xanh và Thông minh, thuộc sở hữu của Vingroup.
  2. Xe taxi sử dụng là xe điện **VinFast (VF5, VFe34, VF8)** — cũng thuộc Vingroup.
  3. Cảm biến "Mắt thần" được lắp đặt trên xe VinFast để đo đếm số lượng người ngồi ghế phụ và ghế sau nhằm đối soát doanh thu nộp về GSM.
* **Cách tôi xử lý:** Tôi yêu cầu AI phải truy xuất các bài báo chính thống (Dân Trí, Tuổi Trẻ, CafeF, Công an Nhân dân) với mốc thời gian cụ thể (vụ án Thái Nguyên 13/5/2026 và vụ án Hà Nội T6/2026 khởi tố 12 bị can, chế tạo ~600 thiết bị do Hoàng Liên Sơn cầm đầu), đồng thời bổ sung định danh pháp lý và công nghệ rõ ràng vào bản đặc tả.

### 🔴 Lần 2: Bẫy tư duy "Problem First, AI Second" ở bài toán Pin VinFast
* **Tình huống:** Khi thảo luận về bài toán suy giảm dung lượng pin xe điện VinFast (Card #2), AI ban đầu đề xuất dùng mô hình AI để theo dõi SOH (State of Health) và báo thay pin khi pin yếu.
* **Tôi phản biện sắc bén:** *"Cái pin nếu nghĩ đơn giản chỉ cần đặt ngưỡng cần thay là được mà nhỉ?"*
* **Nhận thức rút ra:** Nếu chỉ đặt điều kiện `if SOH < 70%: thay pin`, thì đây là **Rule-based thuần túy**, hoàn toàn **KHÔNG CẦN ĐẾN AI**! Việc dùng LLM hay Deep Learning phức tạp cho một ngưỡng cố định là lãng phí tài nguyên và sai bản chất công nghệ.
* **Cách tôi định hướng lại:** AI chỉ thực sự mang lại giá trị gia tăng vượt trội nếu bài toán là **Dự báo trước (Predictive Maintenance)**: Phân tích time-series của đường cong nhiệt độ, độ lệch điện áp cell và chu kỳ sạc nhanh DC qua hàng trăm nghìn km để **dự báo trước 3–6 tháng** thời điểm pack pin sẽ chạm ngưỡng thoái hóa. Điều này giúp VinFast chủ động đặt hàng sản xuất từ nhà máy và điều phối phụ tùng về xưởng trước khi xe của khách hỏng, giảm 70% thời gian xe nằm xưởng. Đây là một bài học đắt giá về việc không "thần thánh hóa" AI khi một câu lệnh rule-based đơn giản có thể giải quyết được.

---

## 4. 🛡️ Bài học về Ranh giới Vận hành (Operational Boundaries)

Một hệ thống AI trong môi trường doanh nghiệp lớn như Vingroup bắt buộc phải có ranh giới an toàn thép:
1. **Nguyên tắc "Human-in-the-loop" (HITL) bất khả xâm phạm:** Trong bài toán chống gian lận Xanh SM, dù AI có phát hiện độ tin cậy gian lận lên tới 99%, AI tuyệt đối không được phép tự động ra quyết định sa thải hay trừ tiền tài xế. AI chỉ được phép lập biên bản nháp `[DRAFT_AUDIT_REPORT]`. Con người (Chuyên viên Fraud Ops) bắt buộc phải là người bấm nút phê duyệt cuối cùng để tránh xử phạt oan do hỏng hóc cảm biến vật lý.
2. **An toàn sinh mạng là ưu tiên số một:** Nghiêm cấm mọi hành vi AI can thiệp vào hệ thống điều khiển lái, phanh hay ngắt điện động cơ xe VinFast khi xe đang lăn bánh.

---

## 5. 🏁 Kết luận cá nhân

Buổi lab giúp tôi hiểu sâu sắc rằng: **Năng lực quan trọng nhất của một AI Product Engineer không phải là viết prompt thật dài hay chạy mô hình thật to, mà là tư duy phản biện (Critical Thinking) để xác định đúng bài toán, chọn đúng công nghệ (Rule vs AI), và thiết lập ranh giới an toàn vững chắc.** AI là một trợ thủ đắc lực, nhưng người cầm lái và chịu trách nhiệm cuối cùng luôn luôn là con người.
