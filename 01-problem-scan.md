# Báo cáo: Phase 1 & 2 - Problem Scan & Quick Assess

**Tên Nhóm:** Group 1
**Họ tên thành viên:** Đinh Trường An
**Email:** dinhtruongan@example.com

---

## Phase 1 — SCAN (5 Bài toán)

Sử dụng 4 Lenses (Lặp lại, Tốn thời gian, AI có thể tốt hơn, Pain từ người khác) để quét các hoạt động vận hành của Vingroup.

| # | Subsidiary | Lens | Mô tả ngắn bài toán |
|---|---|---|---|
| 1 | **Xanh SM** | Lặp lại | Xử lý sự cố hết pin thực địa của tài xế: điều phối viên tra cứu thủ công và soạn tin nhắn hướng dẫn mất nhiều thời gian. |
| 2 | **VinFast** | Tốn thời gian | Đối chiếu hóa đơn sạc điện đối tác: nhân viên kế toán mất nhiều giờ để so khớp dữ liệu sạc ngoài với hệ thống nội bộ. |
| 3 | **Vinhomes** | AI-upgrade | Phân loại & route khiếu nại cư dân: hệ thống hiện tại chậm và phản hồi rập khuôn, mất 12-24h để chuyển yêu cầu đến đúng bộ phận. |
| 4 | **Vinmec** | Pain từ người khác | Soạn tóm tắt hồ sơ xuất viện: bác sĩ mất 20-30 phút/bệnh nhân để trích xuất dữ liệu, dẫn đến quá tải và bệnh nhân phải chờ đợi lâu. |
| 5 | **Vinpearl** | Tốn thời gian | Tự động hóa kiểm tra phòng trống & Group Booking: nhân viên đọc email dài từ công ty lữ hành và tra cứu hệ thống thủ công. |

---

## Phase 2 — QUICK-ASSESS (3 Quick Problem Cards)

Dưới đây là 3 thẻ bài toán tiềm năng nhất được lựa chọn để đánh giá nhanh.

### Card #1
```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #1                                       │
│                                                             │
│ Bài toán (1 câu): Xử lý sự cố hết pin thực địa của tài xế   │
│ Công ty thành viên: [ ] VinFast  [x] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác (Ghi rõ)________  │
│                                                             │
│ Ai đang đau (Actor)? Tài xế (chờ đợi), Điều phối viên       │
│                                                             │
│ Workflow thủ công hiện tại (3-5 bước):                      │
│   1. Nhận báo cáo hết pin ──> 2. Tra vị trí xe ──>          │
│   3. Tìm trạm sạc trống ──> 4. Soạn tin chỉ đường gửi tài xế│
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 3 & 4 (⏱ 12 phút/lượt)│
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 3 & 4 (Soạn tin) │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│   Giảm thời gian xử lý sự cố từ 15 phút ──> dưới 3 phút.    │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

### Card #2
```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #2                                       │
│                                                             │
│ Bài toán (1 câu): Phân loại và route khiếu nại cư dân       │
│ Công ty thành viên: [ ] VinFast  [ ] Xanh SM  [x] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác (Ghi rõ)________  │
│                                                             │
│ Ai đang đau (Actor)? Cư dân (chờ lâu), Ban Quản lý (quá tải)│
│                                                             │
│ Workflow thủ công hiện tại (3-5 bước):                      │
│   1. Cư dân gửi khiếu nại qua App ──> 2. CSKH đọc và        │
│   phân loại ──> 3. CSKH gán ticket cho bộ phận xử lý ──>    │
│   4. Bộ phận xử lý cập nhật trạng thái                      │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2 & 3 (⏱ 12h/lượt)    │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2 (Phân loại)    │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│   Giảm thời gian phản hồi và phân loại từ 12h ──> < 5 phút. │
│                                                             │
│ Quick Architecture: [ ] No AI  [x] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

### Card #3
```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #3                                       │
│                                                             │
│ Bài toán (1 câu): Soạn thảo tóm tắt hồ sơ xuất viện         │
│ Công ty thành viên: [ ] VinFast  [ ] Xanh SM  [ ] Vinhomes  │
│                     [x] Vinmec   [ ] Khác (Ghi rõ)________  │
│                                                             │
│ Ai đang đau (Actor)? Bác sĩ (quá tải giấy tờ), Bệnh nhân    │
│                                                             │
│ Workflow thủ công hiện tại (3-5 bước):                      │
│   1. Thu thập bệnh án, xét nghiệm ──> 2. Bác sĩ đọc và      │
│   chọn lọc thông tin ──> 3. Soạn văn bản tóm tắt ──>        │
│   4. Ký và gửi cho bệnh nhân                                │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2 & 3 (⏱ 25 phút/lượt)│
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2 & 3 (Drafting) │
│                                                             │
│ Đo thành công bằng gì (Metric có số)?                       │
│   Giảm thời gian soạn thảo của bác sĩ từ 25p ──> dưới 5p.   │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```
