# Lab 02 — Problem Scan & Quick Cards: AI Product Scoping (Vin Smart Future)

---

## 🏛️ Bối cảnh

Tôi là **Duy**, AI Product Engineer tại **Vin Smart Future**. Nhiệm vụ của tôi là quét qua toàn bộ hệ sinh thái các công ty thành viên Vingroup để tìm kiếm những điểm nghẽn vận hành (bottleneck) có thể tối ưu hóa bằng trí tuệ nhân tạo.

Thông qua khảo sát thực tế, phân tích báo cáo vận hành nội bộ và tham khảo tin tức báo chí, tôi nhận thấy nhiều quy trình vận hành đang bị rò rỉ hiệu suất nghiêm trọng do xử lý thủ công hoặc thiếu công cụ AI hỗ trợ.

---

# 🔍 Phase 1 — SCAN (Cá nhân)

Sử dụng **4 Lenses** quét qua hoạt động vận hành của các công ty thành viên Vingroup. Ghi lại **5 bài toán/bottleneck** thực tế:

### 4 Lenses đã sử dụng:
1. **Lặp lại (Repetitive):** Tác vụ lặp đi lặp lại nhiều lần hằng ngày.
2. **Tốn thời gian (Time-consuming):** Tác vụ ngốn thời gian xử lý thủ công.
3. **AI có thể tốt hơn (AI-upgrade):** Dịch vụ hiện tại còn chậm hoặc phản hồi rập khuôn.
4. **Pain từ người khác (Stakeholder Pain):** Bottleneck khiến khách hàng hoặc nhân viên phàn nàn.

### 📝 List bài toán của tôi:

| # | Subsidiary (Công ty thành viên) | Lens | Mô tả ngắn bài toán |
|---|----------------------------------|------|---------------------|
| 1 | **Xanh SM (GSM)** | Pain từ người khác | Tài xế sử dụng thiết bị phát hồng ngoại để đánh lừa hệ thống cảm biến "Mắt thần" (cảm biến hồng ngoại nhận diện hành khách tại ghế phụ và hàng ghế sau) trên xe điện VinFast, khiến hệ thống không ghi nhận có khách — tài xế thu tiền cước trực tiếp từ khách mà không nộp về hệ thống của Công ty GSM. **Dẫn chứng thực tế:** ① **Vụ Thái Nguyên (13/5/2026):** Công an tỉnh Thái Nguyên khởi tố, bắt tạm giam 4 đối tượng: Ma Khánh Hùng (người bán thiết bị, cựu tài xế Xanh SM bị sa thải T4/2025), cùng 3 tài xế Trịnh Ngọc Chiến, Đinh Quý Dương, Nguyễn Trung Thành. Thu giữ 8 thiết bị điện tử. Giá bán: 500.000–900.000 đ/thiết bị *(Nguồn: Dân Trí, Tuổi Trẻ, Lao Động, VOV — 13-14/5/2026)*. ② **Vụ Hà Nội (T6/2026):** CA TP. Hà Nội khởi tố **12 bị can**, đối tượng cầm đầu **Hoàng Liên Sơn** (40 tuổi, trú Lào Cai) đã tự chế tạo và bán ra **~600 thiết bị** cho tài xế tại Hà Nội, TP.HCM, Đà Nẵng từ T8/2025–T4/2026. Chi phí sản xuất ~75.000 đ/thiết bị, bán lại 300.000–500.000 đ, thu lợi bất chính ~200 triệu đồng *(Nguồn: CafeF, Báo Nghệ An, Công an Nhân dân — T6/2026)*. ③ **Tội danh:** "Sử dụng mạng máy tính, mạng viễn thông, phương tiện điện tử thực hiện hành vi chiếm đoạt tài sản". Hiện tại hệ thống phát hiện gian lận chủ yếu bằng audit thủ công (reactive), mất hàng tuần-tháng mới phát hiện 1 ca. |
| 2 | **VinFast** | Tốn thời gian | Pin xe điện VinFast suy giảm dung lượng 1-2.3%/năm do thói quen sạc DC quá nhiều, để pin dưới 10%, hoặc sạc đầy 100% liên tục. VinFast cam kết bảo hành pin 10 năm — chi phí thay pin khổng lồ nếu không dự báo sớm. Hệ thống BMS (Battery Management System) thu thập dữ liệu telemetry (nhiệt độ, voltage, SOH) nhưng chưa có AI phân tích dự báo. Xưởng dịch vụ phụ tùng pin chờ lâu do không dự trù được nhu cầu. |
| 3 | **Vinhomes** | Lặp lại | Hệ thống camera AI + cảm biến chuyển động/vỡ kính tại Vinhomes Smart City phát hiện hành vi bất thường (đột nhập, ẩu đả, cháy nổ) → Cảnh báo đổ về trung tâm điều hành 24/7. Tuy nhiên **false positive rate cực cao** (mèo chạy, gió mạnh, trẻ con chơi đùa) → Nhân viên an ninh bị "alert fatigue" → Bỏ qua cảnh báo thật. Thực tế đã có vụ trộm xe máy xảy ra dù camera quay rõ mặt. |
| 4 | **Vinmec** | Tốn thời gian | Bác sĩ Vinmec mất 25–30 phút/bệnh nhân gõ tay bản Tóm tắt hồ sơ xuất viện (Discharge Summary). Quy trình xuất viện phải đồng bộ liên khoa (Dược chuẩn bị thuốc, Tài chính duyệt bảo hiểm) — thường mất nửa ngày. Bệnh nhân cầm đơn toàn thuật ngữ Latin/viết tắt không hiểu cách uống thuốc → uống sai liều → tái nhập viện. MyVinmec đã số hóa kết quả xét nghiệm nhưng chưa "dịch thuật" y lệnh sang ngôn ngữ bệnh nhân. |
| 5 | **Vinpearl / VinWonders** | AI có thể tốt hơn | VinWonders Phú Quốc có bản đồ số thông minh + FASTPASS, nhưng khung giờ 10h-14h các trò chơi hot vẫn có hàng đợi 45-60 phút. Face ID check-in đôi khi lỗi gây ùn tắc cổng vào. Show diễn ONCE kín chỗ nếu khách đến muộn 5 phút. Chưa có hệ thống dự báo bottleneck real-time và gợi ý lộ trình cá nhân hóa cho du khách. |

---

# 🃏 Phase 2 — QUICK-ASSESS (Cá nhân)

Chọn **top 3 bài toán** từ danh sách trên và hoàn thiện **3 Quick Problem Cards** dưới đây:

---

## 📇 Card #1 — Xanh SM: AI Chống Gian Lận Cảm Biến "Mắt Thần"

```
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #1                                       │
│                                                             │
│ Bài toán (1 câu): Tài xế Xanh SM sử dụng thiết bị phát    │
│ hồng ngoại để đánh lừa cảm biến "Mắt thần" trên xe        │
│ VinFast, khiến hệ thống không ghi nhận hành khách —        │
│ tài xế chiếm đoạt toàn bộ cước phí.                        │
│                                                             │
│ Công ty thành viên: [x] Xanh SM (GSM)                      │
│                                                             │
│ Ai đang đau (Actor)?                                        │
│   → Fraud Operations Team tại Trung tâm Giám sát Xanh SM   │
│   → Công ty Xanh SM (mất doanh thu, rủi ro pháp lý)        │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│   1. Hệ thống ghi nhận cuốc xe hoàn thành                  │
│   → 2. Dữ liệu cuốc xe lưu vào database                   │
│   → 3. Team Audit thủ công rà soát báo cáo bất thường      │
│        hàng tuần/tháng                                      │
│   → 4. Phát hiện tài xế có tỉ lệ "cuốc không khách"       │
│        cao bất thường                                       │
│   → 5. Yêu cầu giải trình qua app (48h) → Xử lý kỷ luật  │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất?                            │
│   → Bước 3-4 (⏱ hàng tuần-tháng mới phát hiện 1 ca)        │
│   → Trong thời gian chờ audit, tài xế gian lận tiếp tục    │
│     chiếm đoạt cước phí mỗi ngày                           │
│                                                             │
│ AI có thể nhảy vào hỗ trợ ở bước nào?                       │
│   → Bước 2-3: Phân tích anomaly pattern REAL-TIME từ dữ    │
│     liệu GPS + cảm biến hồng ngoại + lịch sử cuốc xe.     │
│     Phát hiện: "Xe di chuyển theo lộ trình cuốc xe nhưng   │
│     cảm biến báo không có khách" → Fraud Score > 90%        │
│     → Cảnh báo tức thì cho Fraud Ops Team                  │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│   "Phát hiện 95% các ca gian lận cảm biến trong vòng 24h   │
│    (thay vì hàng tuần); giảm thất thoát cước phí ước tính  │
│    15-20 tỷ VNĐ/năm"                                       │
│                                                             │
│ Quick Architecture: [x] LLM  (Anomaly Detection + NLP      │
│   phân tích pattern giải trình của tài xế)                  │
└─────────────────────────────────────────────────────────────┘
```

**Nguồn thực tế:** Dân Trí, Tuổi Trẻ, VOV, Sức khỏe Đời sống (2025-2026). Công an TP Hà Nội đã khởi tố vụ án và 12 bị can liên quan đến đường dây sản xuất, mua bán thiết bị can thiệp hệ thống giám sát Xanh SM (T6/2026).

---

## 📇 Card #2 — VinFast: AI Dự báo Suy giảm Pin Xe Điện (Predictive Battery Health)

```
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #2                                       │
│                                                             │
│ Bài toán (1 câu): Pin xe điện VinFast suy giảm dung lượng  │
│ theo thời gian, nhưng chưa có AI phân tích dữ liệu BMS    │
│ để dự báo xe nào sẽ cần thay pin — xưởng dịch vụ bị động, │
│ khách hàng chờ phụ tùng kéo dài.                           │
│                                                             │
│ Công ty thành viên: [x] VinFast                             │
│                                                             │
│ Ai đang đau (Actor)?                                        │
│   → Đội Service Planning / Quản lý Kho phụ tùng VinFast    │
│   → Khách hàng chờ xe nằm xưởng vì thiếu pin thay thế     │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│   1. Khách hàng phát hiện quãng đường/lần sạc giảm rõ rệt  │
│   → 2. Khách mang xe đến xưởng dịch vụ VinFast             │
│   → 3. Kỹ thuật viên kiểm tra SOH bằng thiết bị chuyên    │
│        dụng (mất 2-3 tiếng)                                 │
│   → 4. Nếu pin cần thay → Đặt hàng phụ tùng pin từ        │
│        tổng kho (cam kết 24h nhưng đôi khi kéo dài)        │
│   → 5. Thay pin và bàn giao xe cho khách                   │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất?                            │
│   → Bước 1-3 (⏱ quá muộn — khách chỉ phát hiện khi pin    │
│     đã suy giảm nghiêm trọng, xe nằm xưởng chờ phụ tùng)  │
│                                                             │
│ AI có thể nhảy vào hỗ trợ ở bước nào?                       │
│   → TRƯỚC Bước 1: AI phân tích dữ liệu telemetry BMS      │
│     (temperature curves, voltage profiles, charge cycles,   │
│     SOH trend) từ hàng trăm nghìn xe qua OTA →             │
│     Dự báo xe nào sẽ cần thay pin trong 3-6 tháng tới →    │
│     Proactive scheduling + pre-order phụ tùng pin           │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│   "Dự báo chính xác 90% các ca cần thay pin trước 3 tháng; │
│    giảm 60% thời gian xe nằm xưởng chờ phụ tùng pin;       │
│    tiết kiệm chi phí bảo hành ước tính 200 tỷ VNĐ/năm"    │
│                                                             │
│ Quick Architecture: [x] LLM  (Time-series analysis +        │
│   NLP tóm tắt báo cáo sức khỏe pin cho Service Team)       │
└─────────────────────────────────────────────────────────────┘
```

**Nguồn thực tế:** VinFast cam kết bảo hành pin 10 năm. Pin suy giảm 1-2.3%/năm (dữ liệu ngành EV 2026). VinFast đã trang bị BMS + E-sim + app theo dõi SOH trên mọi xe nhưng chưa có AI predictive maintenance. Lượng xe bàn giao tăng 72% nửa đầu 2026 → áp lực bảo hành pin cực lớn.

---

## 📇 Card #3 — Vinmec: AI Chuyển hóa Y lệnh & Tóm tắt Xuất viện Đa ngữ

```
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #3                                       │
│                                                             │
│ Bài toán (1 câu): Bác sĩ Vinmec mất 25-30 phút/bệnh nhân │
│ để gõ tay bản Tóm tắt xuất viện, và bệnh nhân nhận đơn    │
│ toàn thuật ngữ y khoa Latin không hiểu cách dùng thuốc.    │
│                                                             │
│ Công ty thành viên: [x] Vinmec                              │
│                                                             │
│ Ai đang đau (Actor)?                                        │
│   → Bác sĩ điều trị (quá tải hành chính, mất thời gian    │
│     khám bệnh thực sự)                                     │
│   → Bệnh nhân (không hiểu đơn thuốc → uống sai liều →     │
│     tái nhập viện)                                          │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│   1. Bác sĩ quyết định cho bệnh nhân xuất viện             │
│   → 2. Bác sĩ gõ tay tóm tắt bệnh án + y lệnh + đơn     │
│        thuốc trên hệ thống EMR (⏱ 25-30 phút)              │
│   → 3. Khoa Dược chuẩn bị thuốc theo đơn                   │
│   → 4. Bộ phận Tài chính/Bảo hiểm duyệt chi phí           │
│        (chờ 2-3 tiếng nếu bảo hiểm bảo lãnh)              │
│   → 5. In giấy ra viện, trao cho bệnh nhân                 │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất?                            │
│   → Bước 2 (⏱ 25-30 phút/ca × hàng chục ca/ngày)          │
│   → Bước 5: Bệnh nhân nhận tóm tắt viết bằng thuật ngữ    │
│     y khoa → Không hiểu → Gọi lại tổng đài hỏi            │
│                                                             │
│ AI có thể nhảy vào hỗ trợ ở bước nào?                       │
│   → Bước 2: AI đọc dữ liệu EMR (bệnh án, xét nghiệm,     │
│     đơn thuốc, y lệnh) → Auto-draft tóm tắt xuất viện     │
│   → Bước 5: AI chuyển hóa y lệnh thành "Cẩm nang phục    │
│     hồi" viết bằng tiếng Việt/Anh bình dân + Lịch uống    │
│     thuốc theo khung giờ (🌅 sáng / ☀️ trưa / 🌙 tối)      │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│   "Tiết kiệm 20 phút/ca xuất viện cho bác sĩ; giảm tỉ lệ │
│    bệnh nhân gọi lại tổng đài hỏi cách dùng thuốc xuống   │
│    dưới 5%; giảm 30% ca tái nhập viện do dùng thuốc sai"   │
│                                                             │
│ Quick Architecture: [x] LLM  (EMR → Structured medical     │
│   summary + Patient-friendly language translation)          │
└─────────────────────────────────────────────────────────────┘
```

**Nguồn thực tế:** Vinmec đã triển khai EMR toàn hệ thống, dừng in phim cứng, đạt giải Healthcare Asia Awards 2025 & ASOCIO Award 2025. App MyVinmec cho xem kết quả xét nghiệm nhưng chưa "dịch thuật" y lệnh. Quy trình xuất viện mất vài tiếng đến nửa ngày do phối hợp liên khoa.

---

## 🗳️ Quyết định lựa chọn bài toán cho nhóm Deep-Dive:

Tôi đề xuất nhóm chọn bài toán **Card #1 — Xanh SM: AI Chống Gian Lận Cảm Biến "Mắt Thần"** để thực hiện Deep-Dive, vì:

### Lý do lựa chọn:
* **Tính thời sự cực cao:** Vụ án hình sự **12 bị can bị khởi tố** vừa xảy ra T6/2026 — có bằng chứng báo chí rõ ràng (Dân Trí, Tuổi Trẻ, VOV).
* **Impact đo lường được:** Thiệt hại ước tính 15-20 tỷ VNĐ/năm — metric ROI rõ ràng.
* **AI Fit rõ ràng:** Anomaly Detection trên dữ liệu cảm biến real-time — đúng bài toán LLM/ML.
* **Ranh giới an toàn thú vị:** AI phát hiện nhưng KHÔNG được tự xử lý kỷ luật — bắt buộc Human-in-the-loop.

### Lý do loại bỏ các thẻ khác:
* **Card #2 (VinFast Dự báo Pin):** Rất hay nhưng cần dữ liệu BMS telemetry thật (dữ liệu nội bộ VinFast, không public) — khó demo prototype trong lab.
* **Card #3 (Vinmec Y lệnh):** Cực kỳ nhạy cảm — lỗi AI trong y tế có thể ảnh hưởng tính mạng bệnh nhân. Cần validation y khoa cực kỳ nghiêm ngặt, vượt quá scope của buổi lab.
