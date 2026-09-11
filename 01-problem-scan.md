# Báo cáo: Phase 1 & 2 - Problem Scan & Quick Assess

**Tên Nhóm:** Group 1
**Họ tên thành viên:** Đinh Trường An
**Email:** dinhtruongan@example.com

---

## Phase 1 - SCAN (5 Bài toán)

Danh sách ưu tiên các pain point người dùng có thể gặp trực tiếp: phải chờ đợi, gọi lại nhiều lần, hoặc không biết tình trạng xử lý.

| # | Subsidiary | Lens | Mô tả ngắn bài toán |
|---|---|---|---|
| 1 | **Xanh SM** | Pain từ người khác | Khách và tài xế không tìm thấy nhau tại bệnh viện, chung cư, sân bay có nhiều cổng; phải gọi qua lại và dễ hủy chuyến. |
| 2 | **Xanh SM** | Pain từ người khác | Khách lo ngại một số tài xế chạy quá tốc độ, phanh gấp hoặc ôm cua gấp; hệ thống hiện chưa phát hiện và can thiệp nhất quán các chuyến có rủi ro. |
| 3 | **Vinhomes** | AI-upgrade | Cư dân báo rò nước, hỏng đèn, thang máy lỗi hoặc tiếng ồn nhưng không biết yêu cầu đã được chuyển cho ai và khi nào được xử lý. |
| 4 | **Vinpearl / VinWonders** | Time-consuming | Kế hoạch vui chơi của gia đình bị đảo lộn khi mưa, khu vui chơi đóng, hoặc sự kiện thay đổi; khách mất thời gian tìm phương án thay thế. |
| 5 | **Vinmec** | AI-upgrade | Bệnh nhân sau xuất viện khó hiểu hướng dẫn, dễ quên lịch tái khám hoặc hiểu sai cách dùng thuốc. |

---

## Phase 2 - QUICK-ASSESS (3 Quick Problem Cards)

### Card #1: Xanh SM - Xác nhận điểm đón tại địa điểm phức tạp

```text
QUICK PROBLEM CARD #1

Bài toán: Khách và tài xế Xanh SM không tìm thấy nhau tại bệnh viện, chung cư, sân bay có nhiều cổng đón.
Công ty thành viên: [x] Xanh SM

Ai đang đau? Khách hàng (chờ đợi, lỡ chuyến), tài xế (mất thời gian, mất cuốc), điều phối/CSKH (nhận cuộc gọi hỗ trợ).

Workflow thủ công hiện tại:
1. Khách đặt xe theo vị trí GPS chung chung
2. Tài xế đến khu vực nhưng không xác định được cổng đón
3. Khách và tài xế gọi/chat qua lại để mô tả mốc địa điểm
4. Nếu vẫn không gặp nhau, khách hủy chuyến hoặc tài xế hủy cuốc

Bước tốn thời gian/lỗi nhất: Bước 3 (trung bình 5-10 phút, dễ hiểu nhầm cổng/sảnh).
AI hỗ trợ: Đọc chat hoặc ghi âm ngắn, nhận diện mốc địa điểm và tạo tin nhắn nháp xác nhận điểm đón cho cả hai bên.

Metric: Giảm tỷ lệ hủy chuyến do không tìm thấy điểm đón 20%; giảm thời gian xác nhận điểm đón từ 7 phút xuống dưới 2 phút.

Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent
Boundary: AI chỉ tạo bản nháp gợi ý; không tự đổi điểm đón, không tự gửi tin nhắn khi chưa có phê duyệt của tài xế/khách.
```

### Card #2: Xanh SM - Phát hiện hành vi lái xe rủi ro

```text
QUICK PROBLEM CARD #2

Bài toán: Phát hiện sớm chuyến xe có hành vi lái xe rủi ro để bảo vệ an toàn khách hàng và hỗ trợ tài xế cải thiện.
Công ty thành viên: [x] Xanh SM

Ai đang đau? Khách hàng (lo lắng, trải nghiệm không an toàn), tài xế (cần phản hồi công bằng để cải thiện), đội an toàn vận hành (khó rà soát toàn bộ chuyến xe).

Workflow hiện tại:
1. Hệ thống lưu dữ liệu GPS/telemetry cơ bản trong quá trình chạy xe
2. Khách chỉ có thể báo cáo khi cảm thấy tài xế lái ẩu hoặc xảy ra sự cố
3. Nhân viên an toàn kiểm tra thủ công từng khiếu nại và dữ liệu liên quan
4. Quản lý liên hệ, nhắc nhở hoặc đào tạo lại tài xế nếu cần

Bước tốn thời gian/lỗi nhất: Bước 3 (khó rà soát dữ liệu của nhiều chuyến xe, dễ bỏ sót pattern rủi ro).
AI hỗ trợ: Phân tích dữ liệu được phép sử dụng như tốc độ, tăng/giảm tốc, phanh gấp, cua gấp và bối cảnh tuyến đường để gắn cờ chuyến có rủi ro; LLM tạo bản tóm tắt dễ đọc cho quản lý.

Metric: Giảm 15% số sự kiện phanh gấp/tăng tốc gấp trên mỗi 100 km trong 3 tháng; 100% cảnh báo rủi ro cao được quản lý xem xét trong 24 giờ.

Quick Architecture: [ ] No AI  [x] Rule  [x] LLM  [ ] Agent
Boundary: Điểm rủi ro là tín hiệu hỗ trợ, không phải kết luận vi phạm. AI không tự phạt, khóa tài khoản hoặc giảm thu nhập tài xế; quản lý phải xem dữ liệu gốc, xem xét bối cảnh và cho tài xế cơ chế giải trình trước mọi quyết định.
```

### Card #3: Vinhomes - Cập nhật tình trạng phản ánh cư dân

```text
QUICK PROBLEM CARD #3

Bài toán: Cư dân gửi phản ánh sự cố nhưng không biết yêu cầu đã được chuyển cho bộ phận nào và khi nào sẽ có người xử lý.
Công ty thành viên: [ ] VinFast  [ ] Xanh SM  [x] Vinhomes

Ai đang đau? Cư dân (thiếu thông tin, phải hỏi lại), CSKH/Ban quản lý (nhận nhiều cuộc hỏi tiến độ), đội kỹ thuật (nhận ticket thiếu thông tin).

Workflow thủ công hiện tại:
1. Cư dân gửi nội dung và ảnh qua app/tổng đài
2. CSKH đọc, phân loại và chuyển ticket thủ công
3. Đội kỹ thuật cập nhật tiến độ không đồng nhất
4. Cư dân gọi lại để hỏi trạng thái

Bước tốn thời gian/lỗi nhất: Bước 2 và 4 (phân loại sai hoặc thiếu cập nhật, có thể kéo dài nhiều giờ).
AI hỗ trợ: Tóm tắt phản ánh, gợi ý nhóm xử lý/mức độ khẩn, và tạo bản nháp cập nhật trạng thái để Ban quản lý duyệt.

Metric: Đạt tỷ lệ chuyển đúng bộ phận ngay lần đầu trên 90%; giảm cuộc hỏi lại tiến độ 25%.

Quick Architecture: [ ] No AI  [x] Rule  [x] LLM  [ ] Agent
Boundary: AI không tự xác nhận đã sửa xong, không tự hứa thời hạn xử lý, và bắt buộc nhân viên phê duyệt cập nhật gửi cư dân.
```
