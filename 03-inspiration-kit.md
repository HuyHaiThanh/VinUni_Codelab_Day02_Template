# Inspiration Kit — Bộ Gợi Ý Tìm Bài Toán (Vin Smart Future Edition)

> **Cẩm nang định hướng và kích hoạt tư duy Scoping bài toán AI thực tế xuyên suốt hệ sinh thái Tập đoàn Vingroup.**  
> *Dành cho AI Product Engineers tại Vin Smart Future, tham khảo khi thực hiện Phase 1 (SCAN) và Phase 2 (QUICK-ASSESS).*

---

## 🧭 1. Triết Lý Cốt Lõi: "Problem First, AI Second"

Trước khi vội vã đưa ra mô hình AI phức tạp, một AI Engineer chuẩn mực tại **Vin Smart Future** phải luôn tự vấn:
1. **Đây có thực sự là một bài toán cần AI không?** Hay chỉ cần một vài dòng lệnh `if-else` (Rule-based) hoặc tự động hóa RPA là đủ?
2. **Chi phí khi AI đưa ra kết quả sai (Cost of False Positive / False Negative) là gì?** Liệu có đe dọa đến tính mạng con người (như xe điện VinFast, phẫu thuật Vinmec) hay gây thiệt hại tài chính lớn?
3. **Dữ liệu thực tế có sẵn sàng không?** Hay đây chỉ là ý tưởng viển vông không có telemetry hoặc logs lưu trữ?

---

## 🔍 2. Bốn Thấu Kính (4 Lenses) Tìm Kiếm Bài Toán

Khi rà soát các hoạt động vận hành tại các công ty thành viên Vingroup, hãy soi chiếu qua **4 Lenses**:

```text
┌──────────────────────────────────────┬──────────────────────────────────────┐
│ 🔄 1. REPETITIVE (Lặp lại)           │ ⏱️ 2. TIME-CONSUMING (Tốn thời gian)  │
│ Những tác vụ diễn ra hàng trăm lần    │ Tác vụ ngốn hàng chục phút/giờ của    │
│ mỗi ngày với quy tắc gần như cố định,│ nhân sự chuyên môn cao (bác sĩ, kỹ   │
│ làm hao mòn năng lượng nhân viên.    │ sư, điều phối viên), tạo nút thắt.   │
├──────────────────────────────────────┼──────────────────────────────────────┤
│ 🚀 3. AI-UPGRADE (AI có thể làm tốt) │ 💔 4. STAKEHOLDER PAIN (Nỗi đau thực)│
│ Dịch vụ/quy trình hiện tại đã có     │ Nỗi bức xúc dai dẳng từ khách hàng,  │
│ nhưng còn chậm, cứng nhắc, phản hồi  │ tài xế, cư dân hoặc rò rỉ thất thoát │
│ rập khuôn hoặc tỷ lệ lỗi cao.        │ tài sản thực tế đã bị cảnh báo/khởi tố│
└──────────────────────────────────────┴──────────────────────────────────────┘
```

---

## 🌟 3. Phân Tích 5 Bài Toán Mẫu Điển Hình (Deep-Analyzed Cases)

Dưới đây là 5 bài toán thực tế tiêu biểu đã được khảo sát kỹ lưỡng trong hệ sinh thái Vingroup:

---

### 🚕 Case 1: Xanh SM (GSM) — AI Giám sát Bất thường & Chống Gian lận Cảm biến "Mắt Thần"
* **Subsidiary:** Công ty CP Di chuyển Xanh và Thông minh (GSM — thành viên Vingroup) phối hợp với VinFast.
* **Lens:** *Stakeholder Pain (Nỗi đau rò rỉ tài chính nghiêm trọng).*
* **Bối cảnh & Bằng chứng thực tế:**
  * Xe điện VinFast (VF5, VFe34, VF8) vận hành trong đội taxi Xanh SM được trang bị hệ thống cảm biến hồng ngoại **"Mắt thần"** ở ghế phụ và hàng ghế sau để tự động ghi nhận khi có hành khách ngồi lên xe, từ đó đối soát doanh thu nộp về GSM.
  * Tài xế đã mua các thiết bị phát tia hồng ngoại bất hợp pháp cắm vào tẩu sạc xe để "làm mù" cảm biến, biến cuốc xe chở khách thành "xe rỗng", bỏ túi 100% tiền cước mặt của khách.
  * **Dẫn chứng khởi tố:** Ngày 13/5/2026, Công an tỉnh Thái Nguyên khởi tố, bắt tạm giam 4 đối tượng (Ma Khánh Hùng, Trịnh Ngọc Chiến, Đinh Quý Dương, Nguyễn Trung Thành), thu giữ 8 thiết bị. Tháng 6/2026, Công an TP. Hà Nội triệt phá đường dây lớn, khởi tố **12 bị can** do Hoàng Liên Sơn cầm đầu, tự chế tạo và bán ra **~600 thiết bị** tại HN, TP.HCM, Đà Nẵng (giá sản xuất ~75.000đ, bán 300.000–500.000đ).
* **Điểm nghẽn:** Audit thủ công theo đợt (batch) mất 14–30 ngày mới phát hiện. Trong thời gian này, cước phí tiếp tục bị chiếm đoạt (ước tính 15–20 tỷ VNĐ/năm).
* **Vì sao Rule-based thất bại & AI là chìa khóa?**
  * *Rule đơn giản (`if speed > 0 and sensor == 0`):* Sẽ báo động sai khi tài xế lái xe một mình đi ăn trưa, đi sạc pin hoặc chuyển bãi.
  * *AI Fit:* **ML Anomaly Detection** phân tích chuỗi hành vi thời gian thực (Mở cửa tại khu dân cư -> di chuyển 7km tuyến phố đông đúc -> dừng mở cửa -> nhưng sensor = 0) kết hợp **LLM Copilot** tự động lập hồ sơ điều tra nghi vấn cho kiểm toán viên duyệt trong 60 giây.

---

### 🔋 Case 2: VinFast — AI Dự báo Sức khỏe Pin EV (Predictive Battery Health & SOH)
* **Subsidiary:** VinFast Auto (Khối Kỹ thuật & Dịch vụ Hậu Mãi).
* **Lens:** *Time-consuming (Thời gian chờ phụ tùng kéo dài).*
* **Bối cảnh:** Pin xe điện suy giảm dung lượng theo chu kỳ sạc/xả, thói quen sạc nhanh DC và nhiệt độ môi trường. VinFast cam kết chính sách bảo hành pin 10 năm. Hệ thống BMS thu thập hàng tỷ điểm dữ liệu viễn thông (telemetry: điện áp cell, nhiệt độ, nội trở).
* **⚠️ Phản biện sắc bén: "Tại sao không chỉ đặt ngưỡng đơn giản `if SOH < 70%: thay pin`?"**
  * Đây là câu hỏi kinh điển về tư duy sản phẩm!
  * **Ngưỡng cố định (Threshold) là Rule-based phản ứng thụ động (Reactive):** Khi SOH đã rớt dưới 70%, pin đã chai hỏng, xe phải nằm xưởng, khách hàng bức xúc vì phải chờ kho tổng điều phối pack pin thay thế từ 5–7 ngày.
  * **AI tạo giá trị ở tính Dự Báo Chủ Động (Predictive):** Mô hình AI Time-series học từ đường cong xả sạc trong quá khứ để **dự báo trước 3–6 tháng** thời điểm một pack pin sẽ chạm ngưỡng thoái hóa. Nhờ đó, VinFast chủ động đặt hàng sản xuất từ nhà máy, vận chuyển pack pin dự phòng về đúng xưởng dịch vụ trước khi khách mang xe đến kiểm định kỳ. Giảm 70% thời gian xe chờ phụ tùng và tối ưu hàng trăm tỷ chi phí lưu kho.

---

### 🏢 Case 3: Vinhomes — Lọc Cảnh Báo Giả (False Alarm Reduction) Camera An Ninh Smart City
* **Subsidiary:** Vinhomes (Ban Quản lý Khu Đô thị Vinhomes Smart City / Ocean Park).
* **Lens:** *Repetitive (Cảnh báo lặp lại gây tê liệt giác quan).*
* **Bối cảnh:** Hàng nghìn camera an ninh tích hợp cảm biến chuyển động, vỡ kính và nhận diện bất thường gửi hàng chục nghìn thông báo mỗi ngày về Trung tâm Điều hành 24/7.
* **Điểm nghẽn:** Tỷ lệ cảnh báo giả (False Positive) lên tới 90% (do mèo hoang chạy qua hàng rào, cành cây đung đưa trong gió bão, trẻ em đá bóng, ánh đèn pha ô tô). Nhân viên an ninh gặp hiện tượng **"Alert Fatigue"** (kiệt sức vì cảnh báo giả), dẫn đến việc tắt bớt chuông hoặc bỏ qua các sự cố đột nhập có thật.
* **AI Solution:** Vision-Language Model (VLM) đa tầng đóng vai trò bộ lọc thông minh cấp 2: Phân tích ngữ cảnh video 5 giây trước và sau sự kiện, nhận diện đối tượng gây kích hoạt, tự động loại bỏ 85% báo động rác, chỉ đẩy các cảnh báo có xác suất rủi ro thực tế cao đến màn hình trực ban.

---

### 🏥 Case 4: Vinmec — Chuyển Hóa Y Lệnh & Tóm Tắt Xuất Viện Đa Ngữ Thông Minh
* **Subsidiary:** Hệ thống Y tế Vinmec.
* **Lens:** *Time-consuming & Stakeholder Pain.*
* **Bối cảnh:** Bác sĩ điều trị mất từ 25 đến 30 phút cho mỗi ca xuất viện để đọc lại toàn bộ bệnh án điện tử (EMR), xét nghiệm, chẩn đoán hình ảnh và gõ tay bản Tóm tắt hồ sơ xuất viện (Discharge Summary).
* **Điểm nghẽn:**
  1. Bác sĩ kiệt sức vì thủ tục hành chính, giảm thời gian thăm khám trực tiếp cho bệnh nhân nội trú.
  2. Bệnh nhân khi ra viện nhận bản tóm tắt ngập tràn thuật ngữ y khoa chuyên sâu và chữ viết tắt Latin (`TID`, `q8h`, `p.o.`), không hiểu rõ cách dùng thuốc dẫn đến uống sai liều, gây tác dụng phụ hoặc phải tái nhập viện.
* **AI Solution:** LLM chuyên ngành y tế đọc EMR để tự động tạo bản nháp (auto-draft) tóm tắt xuất viện chuẩn y khoa (bác sĩ chỉ cần 2 phút để kiểm tra và ký số); đồng thời tự động biên dịch sang "Cẩm nang chăm sóc tại nhà" viết bằng ngôn ngữ đời thường, chia lịch uống thuốc rõ ràng theo biểu tượng 🌅 Sáng / ☀️ Trưa / 🌙 Tối.

---

### 🎢 Case 5: Vinpearl / VinWonders — Dự Báo Hàng Đợi & Điều Phối Luồng Khách Động
* **Subsidiary:** Vinpearl / VinWonders (Phú Quốc, Nha Trang, Nam Hội An).
* **Lens:** *AI-upgrade (Nâng cấp trải nghiệm khách hàng).*
* **Bối cảnh:** Tại các công viên chủ đề VinWonders, vào các khung giờ cao điểm (10h-14h), các trò chơi cảm giác mạnh thu hút đông khách có thời gian xếp hàng chờ đợi lên đến 45–60 phút, gây mệt mỏi cho gia đình có trẻ nhỏ.
* **Điểm nghẽn:** Khách hàng đổ xô vào cùng một khu vực theo thói quen tự phát. Ứng dụng bản đồ số hiện tại chỉ hiển thị thời gian chờ tĩnh, chưa có cơ chế điều phối chủ động.
* **AI Solution:** Mô hình AI dự báo mật độ dòng người thời gian thực kết hợp thuật toán gợi ý lộ trình cá nhân hóa (Recommender System): Chủ động gửi thông báo qua App VinWonders gợi ý du khách chuyển hướng sang các phân khu trải nghiệm hoặc nhà hàng ẩm thực đang vắng người kèm mã ưu đãi tức thì, giúp san phẳng lưu lượng và giảm 35% thời gian chờ trung bình.

---

## 📋 4. Bảng Tổng Hợp 15 Ý Tưởng Scoping Theo Hệ Sinh Thái Vingroup

| # | Subsidiary | Tên ý tưởng bài toán | Lens | Mô tả ngắn & Dữ liệu đầu vào |
|---|---|---|---|---|
| **1** | **Xanh SM** | Chống gian lận cảm biến "Mắt thần" | Stakeholder Pain | Nhận diện thiết bị phá hồng ngoại qua so khớp lộ trình GPS vs trạng thái ghế. |
| **2** | **Xanh SM** | Điều vận thông minh (Smart Dispatching) | Tốn thời gian | Phân tích tin nhắn thoại/văn bản của tài xế và vị trí thực tế để chỉ định điểm đón tối ưu. |
| **3** | **Xanh SM** | Khai phá lý do khách hàng hủy chuyến | Stakeholder Pain | LLM phân tích transcript ghi âm cuộc gọi hủy chuyến và ghi chú cuốc xe để tìm pattern lỗi. |
| **4** | **VinFast** | Dự báo suy giảm sức khỏe pin xe điện | Tốn thời gian | Time-series AI phân tích telemetry BMS dự báo trước 3 tháng các pack pin cần thay thế. |
| **5** | **VinFast** | Phân loại lỗi xe từ mô tả tiếng Việt | AI-upgrade | Khách hàng mô tả tiếng Việt tự nhiên, AI trích xuất triệu chứng và map vào mã lỗi chuẩn OBD. |
| **6** | **VinFast** | Đối chiếu tự động hóa đơn trạm sạc đối tác| Lặp lại | So khớp dữ liệu sạc điện từ hàng nghìn trụ sạc đối tác ngoài với hóa đơn tài chính hàng tuần. |
| **7** | **Vinhomes** | Lọc báo động giả camera an ninh Smart City| Lặp lại | VLM phân tích bối cảnh video loại bỏ 85% báo động rác từ vật nuôi, gió bão. |
| **8** | **Vinhomes** | Phân luồng phản ánh cư dân trên Resident App| Lặp lại | Tự động phân loại khiếu nại (điện, nước, vệ sinh, ồn ào) gửi thẳng tới kỹ thuật tòa nhà. |
| **9** | **Vinhomes** | Trợ lý hỗ trợ thủ tục thi công nội thất | AI-upgrade | Hướng dẫn cư dân hoàn thiện hồ sơ đăng ký thi công căn hộ, đối soát tự động quy chuẩn kỹ thuật. |
| **10** | **Vinpearl** | Khai thác phản hồi du khách đa kênh | Stakeholder Pain | Thu thập review từ Agoda, Booking, Google Maps, phân loại phàn nàn khẩn cấp gửi GM khách sạn. |
| **11** | **Vinpearl** | Trích xuất thông tin email đặt phòng đoàn | Tốn thời gian | Đọc email hợp đồng tour lữ hành phức tạp, tự động trích xuất số lượng phòng và draft đơn đặt phòng. |
| **12** | **VinWonders** | Dự báo luồng khách & San phẳng hàng đợi | AI-upgrade | Dự báo nút thắt cổ chai dòng người và gợi ý lộ trình di chuyển thông minh theo thời gian thực. |
| **13** | **Vinmec** | Tóm tắt hồ sơ xuất viện & Cẩm nang thuốc | Tốn thời gian | LLM tổng hợp EMR thành bản tóm tắt xuất viện và dịch sang cẩm nang uống thuốc cho bệnh nhân. |
| **14** | **Vinmec** | Sàng lọc & Gợi ý chuyên khoa ban đầu | AI-upgrade | Hỏi đáp triệu chứng ban đầu với bệnh nhân để gợi ý đúng chuyên khoa khám, tránh đi nhầm phòng. |
| **15** | **VinUni** | Trợ lý phản hồi bài tập lập trình sư phạm | Lặp lại | Phân tích bài nộp code của sinh viên, chỉ ra lỗi logic và đưa ra gợi ý sư phạm gợi mở (Socratic). |

---

## 🛡️ 5. Cẩm Nang Thiết Lập Ranh Giới Vận Hành (Operational Boundaries)

Một sản phẩm AI của **Vin Smart Future** chỉ được ban lãnh đạo phê duyệt khi chứng minh được ranh giới an toàn tuyệt đối:

1. **Mảng Giao Thông & Xe Điện (VinFast / Xanh SM):**
   * ❌ **CẤM:** AI không được phép can thiệp trực tiếp vào hệ thống điều khiển lái, phanh hoặc ngắt nguồn động cơ khi xe đang lăn bánh.
   * ❌ **CẤM:** AI không được tự động sa thải hay trừ tiền tài xế khi chưa có xác nhận từ chuyên viên Fraud Ops.
   * ✅ **PHẢI CÓ:** Nhãn `[DRAFT_ONLY]` hoặc `[DRAFT_AUDIT_REPORT]` cho mọi văn bản đề xuất.

2. **Mảng Y Tế & Chăm Sóc Sức Khỏe (Vinmec):**
   * ❌ **CẤM:** AI không được tự ý ký đơn thuốc hoặc ra quyết định chẩn đoán lâm sàng cuối cùng.
   * ✅ **PHẢI CÓ:** Bác sĩ điều trị bắt buộc phải kiểm tra, xác nhận và ký số điện tử (Human-in-the-loop 100%).

3. **Mảng Đô Thị & Tài Chính (Vinhomes / Vingroup):**
   * ❌ **CẤM:** AI không được tự ý hoàn tiền, miễn trừ phí quản lý hoặc can thiệp dữ liệu hợp đồng pháp lý của cư dân.
   * ✅ **PHẢI CÓ:** Luôn có đường dẫn Fallback quay về nhân viên chăm sóc khách hàng truyền thống khi AI không đạt ngưỡng tin cậy (Confidence < 80%).
