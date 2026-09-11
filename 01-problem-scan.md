# 01 — Problem Scan & Quick Cards

> **Học viên:** Nguyễn Hải Hiếu
> **Mã học viên** 2A202602681
> **Branch:** `nguyenhaihieu`
> **Vai trò:** AI Product Engineer — Vin Smart Future (Vingroup)
> **Nội dung:** Phase 1 (SCAN) + Phase 2 (QUICK-ASSESS) của Lab 02.

---

# 🔍 Phase 1 — SCAN: Quét cơ hội qua 4 Lenses

Tôi quét trải đều qua 5 công ty thành viên để so sánh mức độ đau giữa các mảng kinh doanh, thay vì đào sâu một mảng duy nhất. Mỗi bài toán dưới đây đều là một quy trình thủ công có người thật ngồi làm hằng ngày.

| # | Subsidiary | Lens | Mô tả ngắn bài toán |
|---|------------|------|---------------------|
| 1 | **VinFast** | Lặp lại | Nhân viên Trung tâm Bảo hành phân loại thủ công phiếu yêu cầu bảo hành từ đại lý ủy quyền: đọc mô tả lỗi viết bằng tiếng Việt tự do, gán mã lỗi kỹ thuật, rồi route về đúng tổ kỹ thuật (pin / phần mềm / thân vỏ). Khoảng 200 phiếu/ngày, 6-8 phút/phiếu. |
| 2 | **Xanh SM** | Pain từ người khác | Tài xế xe máy điện phàn nàn hệ thống gợi ý trạm đổi pin không tính tới hàng chờ thực tế. Giờ cao điểm tới nơi phải đợi thêm 10-15 phút hoặc trạm đã hết pin đầy. |
| 3 | **Vinhomes** | Tốn thời gian | Ban quản lý tòa nhà soạn tay phản hồi cho đơn đề nghị sửa chữa căn hộ của cư dân trên app: đọc đơn, tra lịch đội kỹ thuật, viết thư xác nhận lịch hẹn. Mất 10-12 phút/đơn, khoảng 60 đơn/ngày/khu đô thị. |
| 4 | **Vinmec** | Tốn thời gian | Điều dưỡng tổng hợp tiền sử bệnh nhân trước ca khám: đọc rải rác hồ sơ cũ, đơn thuốc và kết quả xét nghiệm để viết một bản tóm tắt 1 trang cho bác sĩ. Mất 15-20 phút cho mỗi bệnh nhân tái khám. |
| 5 | **Vinpearl** | AI-upgrade | Tổng đài đặt phòng trả lời câu hỏi của khách quốc tế ngoài giờ hành chính bằng kịch bản có sẵn, không xử lý được câu hỏi ghép (giá phòng cộng đưa đón sân bay cộng vé VinWonders). Khách chờ tới sáng hôm sau, tỉ lệ rớt đơn cao vào mùa cao điểm. |

**Ghi chú về lenses:** bài toán 1 thuộc lens *Lặp lại*, bài 3 và 4 thuộc lens *Tốn thời gian*, bài 5 thuộc lens *AI-upgrade*, bài 2 thuộc lens *Pain từ người khác*. Cả 4 lenses đều được phủ.

---

# 🃏 Phase 2 — QUICK-ASSESS: 3 Quick Problem Cards

Tôi chọn top 3 là **#1 (VinFast bảo hành)**, **#3 (Vinhomes sửa chữa căn hộ)** và **#5 (Vinpearl đặt phòng đa ngôn ngữ)**. Ba bài này có chung đặc điểm: đầu vào là văn bản tiếng Việt tự do, đầu ra là văn bản có cấu trúc, và có sẵn log lịch sử để làm dữ liệu đánh giá.

Hai bài bị loại. Bài **#2** phụ thuộc dữ liệu telemetry trạm đổi pin theo thời gian thực mà tôi không xác minh được là có tồn tại, và bản chất là bài toán tối ưu hàng chờ chứ không phải bài toán ngôn ngữ. Bài **#4** có rủi ro lâm sàng cao, tóm tắt sót tiền sử dị ứng có thể gây hại trực tiếp cho bệnh nhân, cần một quy trình kiểm duyệt y khoa nằm ngoài phạm vi một buổi lab.

---

## Card #1 — VinFast: Phân loại và định tuyến phiếu bảo hành

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #1                                       │
│                                                             │
│ Bài toán: Phiếu bảo hành từ đại lý viết bằng ngôn ngữ tự do │
│ phải được đọc, gán mã lỗi và route thủ công về đúng tổ kỹ   │
│ thuật, gây tồn đọng hàng chờ vào đầu tuần.                  │
│ Công ty thành viên: [x] VinFast                             │
│                                                             │
│ Ai đang đau? Nhân viên tiếp nhận Trung tâm Bảo hành (đọc    │
│ 200 phiếu/ngày) và khách hàng (chờ phản hồi lâu).           │
│                                                             │
│ Workflow thủ công hiện tại (4 bước):                        │
│   1. Nhận phiếu từ đại lý qua email/portal                  │
│   ──> 2. Đọc mô tả lỗi viết tay, đoán ý khách               │
│   ──> 3. Tra bảng mã lỗi kỹ thuật, gán mã phù hợp           │
│   ──> 4. Chuyển phiếu về tổ pin / phần mềm / thân vỏ        │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2-3 (⏱ 5 phút/phiếu)  │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2-3              │
│ (Đọc mô tả ──> đề xuất mã lỗi và tổ xử lý kèm độ tin cậy)   │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│ 1. Giảm thời gian xử lý 1 phiếu từ 7 phút ──> dưới 2 phút   │
│ 2. Độ chính xác gán mã lỗi đạt trên 90% so với nhãn của     │
│    chuyên viên kỹ thuật trên tập 300 phiếu lịch sử.         │
│                                                             │
│ Quick Architecture: [x] LLM Feature                         │
│ (Phân loại văn bản và trích xuất có cấu trúc, người duyệt)  │
└─────────────────────────────────────────────────────────────┘
```

**Ranh giới sơ bộ:** AI chỉ đề xuất mã lỗi và tổ xử lý. Cấm tự đóng phiếu, cấm tự cam kết thời hạn sửa chữa với khách. Phiếu có độ tin cậy dưới ngưỡng rơi về hàng chờ người xử lý như cũ.

---

## Card #2 — Vinhomes: Phản hồi đơn đề nghị sửa chữa căn hộ

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #2                                       │
│                                                             │
│ Bài toán: Ban quản lý soạn tay từng thư phản hồi cho đơn    │
│ đề nghị sửa chữa của cư dân, dẫn tới phản hồi chậm và văn   │
│ phong không đồng nhất giữa các tòa nhà.                     │
│ Công ty thành viên: [x] Vinhomes                            │
│                                                             │
│ Ai đang đau? Nhân viên Ban quản lý tòa nhà và cư dân đang   │
│ chờ xác nhận lịch sửa chữa.                                 │
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│   1. Nhận đơn trên app Vinhomes Resident                    │
│   ──> 2. Đọc đơn, xác định hạng mục (điện/nước/điều hòa)    │
│   ──> 3. Mở Excel lịch đội kỹ thuật tìm khung giờ trống     │
│   ──> 4. Soạn thư xác nhận lịch hẹn gửi cư dân              │
│   ──> 5. Cập nhật trạng thái đơn trên hệ thống              │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 4 (⏱ 6 phút/đơn)      │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2 và 4           │
│ (Phân loại hạng mục ──> soạn nháp thư theo template chuẩn)  │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│ 1. Giảm thời gian soạn phản hồi từ 10 phút ──> dưới 3 phút  │
│ 2. 80% thư nháp được nhân viên duyệt mà không sửa nội dung. │
│                                                             │
│ Quick Architecture: [x] LLM Feature                         │
│ (Rule-based lo phần tra lịch, LLM lo phần soạn văn bản)     │
└─────────────────────────────────────────────────────────────┘
```

**Ranh giới sơ bộ:** AI tuyệt đối không được nhắc tới phí dịch vụ, tranh chấp sở hữu, hay cam kết bồi thường. Mọi thư đều là bản nháp, nhân viên bấm duyệt mới gửi đi.

---

## Card #3 — Vinpearl: Trợ lý đặt phòng đa ngôn ngữ ngoài giờ

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #3                                       │
│                                                             │
│ Bài toán: Câu hỏi ghép của khách quốc tế ngoài giờ hành     │
│ chính không được trả lời, khách chờ tới sáng hôm sau và     │
│ chuyển sang đặt qua OTA nước ngoài.                         │
│ Công ty thành viên: [x] Vinpearl / VinWonders               │
│                                                             │
│ Ai đang đau? Khách quốc tế và đội Kinh doanh phòng          │
│ (mất đơn vào khung 22h-7h).                                 │
│                                                             │
│ Workflow thủ công hiện tại (4 bước):                        │
│   1. Khách nhắn câu hỏi trên web/Facebook lúc 23h           │
│   ──> 2. Bot kịch bản trả lời rập khuôn, không khớp câu hỏi │
│   ──> 3. Hội thoại xếp hàng chờ nhân viên ca sáng           │
│   ──> 4. Nhân viên trả lời lúc 8h30 hôm sau, khách đã đặt   │
│        chỗ khác                                             │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 3 (⏱ chờ 9 tiếng)     │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2                │
│ (Trả lời câu hỏi ghép dựa trên tài liệu giá và dịch vụ)     │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│ 1. Tỉ lệ hội thoại ngoài giờ được trả lời trong 60 giây     │
│    đạt trên 70%.                                            │
│ 2. Không quá 2% câu trả lời sai giá so với bảng giá gốc.    │
│                                                             │
│ Quick Architecture: [x] LLM Feature (RAG trên tài liệu giá) │
└─────────────────────────────────────────────────────────────┘
```

**Ranh giới sơ bộ:** AI chỉ báo giá lấy từ tài liệu được cấp, cấm tự suy ra giá hay tự áp khuyến mãi. Cấm xác nhận đặt phòng và cấm xử lý thanh toán. Khi câu hỏi nằm ngoài phạm vi tài liệu, AI phải chuyển hội thoại cho người và nói rõ điều đó với khách.

---

# 🗳️ Ứng viên tôi mang vào buổi họp nhóm

Tôi đề xuất nhóm chọn **Card #1 (VinFast bảo hành)** để deep-dive, vì ba lý do.

1. **Quy trình có ranh giới rõ.** Bốn bước tuần tự, mỗi bước có một người chịu trách nhiệm, nên vẽ sơ đồ và đo thời gian cho Gate 1 rất thuận.
2. **Có nhãn đối chiếu sẵn.** Phiếu bảo hành lịch sử đã được chuyên viên gán mã lỗi, nên đo được độ chính xác ngay mà không cần gán nhãn lại từ đầu.
3. **Rủi ro khi AI sai nằm trong tầm kiểm soát.** Phiếu route nhầm tổ chỉ tốn thêm một lần chuyển tay, không gây hại cho người hay tài sản.
