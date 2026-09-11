# Báo Cáo Phân Tích Sâu (Deep-Dive Report) — Vin Smart Future

> **Dự án:** Hệ thống AI Giám sát Bất thường & Chống Gian lận Cảm biến "Mắt thần" (Xanh SM / GSM)  
> **Đơn vị thực hiện:** Vin Smart Future — AI Engineering Team  
> **Tác giả:** Duy — AI Product Engineer  
> **Công ty thành viên:** Xanh SM (Công ty CP Di chuyển Xanh và Thông minh — GSM, thành viên Vingroup) phối hợp cùng VinFast  

---

# 🏗️ Phase 3 — DEEP-DIVE

## 3.1. Sơ đồ Quy trình Vận hành Hiện tại (Current-State Workflow Mapping)

Quy trình phát hiện và xử lý gian lận cước xe taxi Xanh SM bằng cách can thiệp cảm biến "Mắt thần" trên xe điện VinFast hiện nay:

```text
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│ Bước 1          │     │ Bước 2          │     │ Bước 3          │     │ Bước 4          │
│ Tài xế bật thiết│     │ Xe chở khách lưu│     │ Dữ liệu hành    │     │ Định kỳ tuần/   │
│ bị phát hồng    │ ──→ │ thông nhưng cảm │ ──→ │ trình đổ về kho │ ──→ │ tháng, Auditor  │
│ ngoại làm mù mắt│     │ biến ghế báo 0  │     │ dữ liệu tập     │     │ chạy query SQL  │
│ thần ghế phụ/sau│     │ (coi như xe rỗng│     │ trung GSM       │     │ lọc xe nghi vấn │
│                 │     │                 │     │                 │     │                 │
│ Actor: Driver   │     │ Actor: VinFast  │     │ Actor: Telemetry│     │ Actor: Auditor  │
│ ⏱ 1 phút        │     │ ⏱ 30-60 phút    │     │ ⏱ Realtime log  │     │ ⏱ 3-5 ngày 🔴   │
│ In: Công tắc tắt│     │ In: Vận tốc GPS │     │ In: Telemetry   │     │ In: Script SQL  │
│ Out: Sensor lóa │     │ Out: Sensor = 0 │     │ Out: DB Records │     │ Out: List xe    │
└─────────────────┘     └─────────────────┘     └─────────────────┘     └─────────────────┘
                                                                                 │
                                                                                 ▼
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│ Bước 7          │     │ Bước 6          │     │ Bước 5          │     │ Bước 4b         │
│ Hội đồng kỷ luật│     │ Tài xế giải     │     │ Gửi ticket yêu  │     │ Chuyên viên mở  │
│ họp ra quyết    │ ──→ │ trình hoặc né   │ ──→ │ cầu tài xế giải │ ──→ │ camera hành     │
│ định sa thải    │     │ tránh phản hồi  │     │ trình qua app   │     │ trình soi đối   │
│                 │     │                 │     │                 │     │ chiếu thủ công  │
│ Actor: Council  │     │ Actor: Driver   │     │ Actor: Auditor  │     │ Actor: Auditor  │
│ ⏱ 7-14 ngày     │     │ ⏱ 48h - 5 ngày  │     │ ⏱ 1 ngày        │     │ ⏱ 2-3 ngày 🔴   │
│ Out: Quyết định │     │ Out: Tường trình│     │ Out: Ticket app │     │ Out: Bằng chứng │
└─────────────────┘     └─────────────────┘     └─────────────────┘     └─────────────────┘

🔴 Điểm nghẽn cổ chai (Bottlenecks):
  - Bước 4: Kiểm toán thủ công theo lô (batch audit) gây độ trễ từ 1 đến 4 tuần.
  - Bước 4b: Đối chiếu mắt người giữa camera hành trình và dữ liệu định vị GPS mất 30-45 phút/ca.
⏱ Tổng thời gian xử lý chu trình: 14 – 30 ngày/vụ vi phạm.
Hậu quả: Tài xế gian lận kịp thực hiện hàng trăm chuyến xe lậu, thất thoát cước phí lũy kế hàng tỷ đồng.
```

---

## 3.2. Bảng Mô Tả Bài Toán 6 Trường (Problem Statement — 6-Field)

| STT | Trường thông tin (Field) | Nội dung đặc tả chi tiết |
|:---:|---|---|
| **1** | **Actor / Operator** *(Ai đang chịu trách nhiệm chính?)* | Chuyên viên Giám sát Gian lận (Fraud Operations Specialist) thuộc Trung tâm Điều hành & Giám sát Xanh SM (GSM). |
| **2** | **Current Workflow** *(Quy trình thủ công hiện tại)* | Dữ liệu cuốc xe (GPS, đồng hồ cước, cảm biến ghế "Mắt thần" VinFast) đồng bộ về Data Warehouse. Hằng tuần, kiểm toán viên chạy SQL query trích xuất các xe di chuyển nhiều nhưng doanh thu thấp. Kiểm toán viên sau đó kiểm tra video camera hành trình thủ công, soạn công văn nghi vấn và gửi qua app yêu cầu tài xế giải trình trong 48h. Quy trình mất từ 14 đến 30 ngày. |
| **3** | **Bottleneck** *(Điểm nghẽn nghiêm trọng nhất)* | **Bước 4 & Bước 4b:** Độ trễ kiểm tra quá lớn (hàng tuần). Việc kiểm tra bằng mắt người đối chiếu GPS vs Camera vs Lịch sử cuốc xe gây quá tải nghiêm trọng cho đội ngũ Fraud Ops. Tài xế gian lận tẩu tán thiết bị hoặc tiếp tục trục lợi trước khi bị phát hiện. |
| **4** | **Business Impact** *(Thiệt hại kinh doanh thực tế)* | Cơ quan Công an đã triệt phá đường dây khởi tố 12 bị can, chế tạo ~600 thiết bị phá cảm biến tại HN, HCM, Đà Nẵng (T6/2026). Thiệt hại doanh thu cước của GSM ước tính **15–20 tỷ VNĐ/năm**. Gây sai lệch dữ liệu phân tích vận hành xe điện VinFast, ảnh hưởng uy tín thương hiệu dịch vụ taxi 5 sao của Vingroup. |
| **5** | **Success Metric** *(Chỉ số thành công có số)* | 1. **Thời gian phát hiện (Detection Latency):** Rút ngắn từ 14-30 ngày xuống dưới **15 phút** ngay sau khi kết thúc chuyến xe.<br>2. **Độ chính xác (Precision & Recall):** Tỷ lệ phát hiện gian lận (Recall) đạt **≥ 95%**, tỷ lệ cảnh báo sai (False Positive Rate) **≤ 3%**.<br>3. **Bảo vệ doanh thu:** Thu hồi và ngăn chặn thất thoát tối thiểu **15 tỷ VNĐ/năm** cho GSM. |
| **6** | **Operational Boundary** *(Ranh giới vận hành bắt buộc)* | **ĐƯỢC PHÉP:** AI được quyền phân tích đa nguồn telemetry (GPS, tốc độ, cảm biến cửa mở/đóng, Mắt thần), chấm điểm rủi ro (Fraud Risk Score: 0-100), tự động trích xuất timeline vi phạm và soạn bản nháp hồ sơ kiểm toán `[DRAFT_AUDIT_REPORT]`.<br>**CẤM TUYỆT ĐỐI:** AI không được tự ý khóa tài khoản tài xế, không tự động trừ tiền lương/ví, không được phát tín hiệu can thiệp ngắt nguồn điện hoặc phanh xe VinFast khi đang lăn bánh. Bắt buộc phải có chuyên viên Fraud Ops kiểm tra và bấm duyệt (Human-in-the-loop). |

---

## 3.3. Quy Trình Tương Lai & Đánh Giá AI Fit (Future-State Flow & AI Fit)

### Đánh giá AI Fit: Vì sao là ML Anomaly Detection + LLM Feature?
* **Không thể dùng Rule-based thuần túy:** Nếu chỉ viết luật `if speed > 20 and sensor_mat_than == 0: flag_fraud()`, hệ thống sẽ cảnh báo sai hàng loạt khi tài xế chạy xe đi ăn trưa, đi sạc pin, hoặc di chuyển vị trí đón khách không chở khách.
* **Mô hình kết hợp tối ưu:**
  1. **ML Anomaly Detection (Time-series / Isolation Forest / XGBoost):** Phát hiện bất thường từ chuỗi hành vi: *Xe dừng tại khu dân cư/trung tâm thương mại -> Cửa sau mở/đóng -> Xe di chuyển 7km trong giờ cao điểm theo lộ trình quen thuộc -> Cửa mở/đóng -> Nhưng cảm biến Mắt thần báo 0 trong suốt hành trình*.
  2. **LLM Copilot (Incident Profiler):** Đọc các chỉ số bất thường từ ML engine, trích xuất tọa độ điểm đón/trả nghi vấn, so khớp với lịch sử cuốc xe và soạn thảo báo cáo kiểm toán hoàn chỉnh có trích dẫn dữ liệu khách quan, giúp chuyên viên chỉ mất 60 giây để ra quyết định.

### Sơ đồ quy trình tương lai (Future-State Flow):

```text
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│ Bước 1          │     │ Bước 2          │     │ Bước 3          │     │ Bước 4          │
│ Dữ liệu telemetry│    │ 🔵 AI Anomaly   │     │ 🔵 LLM Agent    │     │ 🟢 Fraud Ops    │
│ thời gian thực  │ ──→ │ Engine phân tích│ ──→ │ tổng hợp timeline│ ──→│ Specialist xem  │
│ (GPS, cửa, Mắt  │     │ chuỗi hành vi   │     │ & soạn dự thảo  │     │ báo cáo & bấm   │
│ thần VinFast)   │     │ Fraud Score>85% │     │ [DRAFT_REPORT]  │     │ phê duyệt ticket│
└─────────────────┘     └─────────────────┘     └─────────────────┘     └─────────────────┘
                                                                                 │
                                                                                 ▼
                                                                        ↩️ Fallback:
                                                                        Nếu Fraud Score
                                                                        nằm trong dải xám
                                                                        (50-84%), đưa vào
                                                                        hàng đợi audit tuần,
                                                                        không gây phiền tài xế.
```

---

# 🏁 Phase 5 — EVALUATE: Quyết định Triển khai

### Bảng Kiểm Tra Độ Sẵn Sàng (AI Readiness Checklist):
- [x] **Dữ liệu:** Dữ liệu định vị GPS xe VinFast, nhật ký mở đóng cửa, trạng thái cảm biến hồng ngoại và lịch sử đặt xe trên app Xanh SM đã được số hóa tập trung 100%.
- [x] **Kiểm soát rủi ro:** Cơ chế Human-in-the-loop (Chuyên viên Fraud Ops xác thực) loại bỏ rủi ro xử phạt nhầm do lỗi hỏng hóc phần cứng cảm biến tự nhiên.
- [x] **Sự sẵn sàng của các bên liên quan (Stakeholders):** Ban Lãnh đạo GSM và Khối Vận hành ưu tiên cao nhất cho dự án nhằm dứt điểm tình trạng thất thoát cước phí và bảo vệ hình ảnh thương hiệu taxi điện văn minh.

### Quyết định Đầu tư:
**[ x ] GO (Phê duyệt phát triển MVP trong vòng 6 tuần)**

### Lý giải Quyết định (Justification):
1. **Lợi ích kinh tế (Business Value):** Chi phí phát triển và vận hành hệ thống AI ước tính khoảng 300 - 500 triệu VNĐ/năm, trong khi giá trị ngăn chặn thất thoát doanh thu cước đạt từ 15 đến 20 tỷ VNĐ/năm — tỷ suất hoàn vốn (ROI) đạt trên 30x.
2. **Khả thi kỹ thuật:** Kiến trúc không đòi hỏi xây dựng LLM từ đầu mà tận dụng pipeline dữ liệu telemetry có sẵn của VinFast/GSM, kết hợp mô hình phân loại bất thường đã được kiểm chứng trong ngành fintech/ride-hailing.
3. **Tính bền vững & Quy mô:** Hệ thống có thể triển khai mở rộng lập tức cho toàn bộ các đội xe Xanh SM tại các thị trường quốc tế (Lào, Indonesia, Philippines) mà không làm tăng biên chế nhân sự kiểm toán.
