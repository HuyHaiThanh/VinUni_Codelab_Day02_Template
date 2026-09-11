# Báo cáo: Phase 1 & 2 - Problem Scan & Quick Assess

**Tên Nhóm:** Group 1
**Họ tên thành viên:** Đinh Trường An
**Email:** truongan1203.hp@gmail.com

---

## Phase 1 - SCAN (5 Bài toán)

Danh sách ưu tiên các pain point người dùng có thể gặp trực tiếp: phải chờ đợi, gọi lại nhiều lần, hoặc không biết tình trạng xử lý.

| # | Subsidiary | Lens | Mô tả ngắn bài toán |
|---|---|---|---|
| 1 | **Xanh SM** | Pain từ người khác | Khách ghim điểm đón trong ngõ sâu hoặc địa điểm có nhiều cổng; bản đồ vẫn route được nhưng ô tô khó đi vào/quay đầu, khiến hai bên gọi qua lại và dễ hủy chuyến. |
| 2 | **Xanh SM** | Pain từ người khác | Khách lo ngại một số tài xế chạy quá tốc độ, phanh gấp hoặc ôm cua gấp; hệ thống hiện chưa phát hiện và can thiệp nhất quán các chuyến có rủi ro. |
| 3 | **Vinhomes** | AI-upgrade | Cư dân báo rò nước, hỏng đèn, thang máy lỗi hoặc tiếng ồn nhưng không biết yêu cầu đã được chuyển cho ai và khi nào được xử lý. |
| 4 | **Vinpearl / VinWonders** | Time-consuming | Kế hoạch vui chơi của gia đình bị đảo lộn khi mưa, khu vui chơi đóng, hoặc sự kiện thay đổi; khách mất thời gian tìm phương án thay thế. |
| 5 | **Vinmec** | AI-upgrade | Bệnh nhân sau xuất viện khó hiểu hướng dẫn, dễ quên lịch tái khám hoặc hiểu sai cách dùng thuốc. |

---

## Phase 2 - QUICK-ASSESS (3 Quick Problem Cards)

### Card #1: Xanh SM - Xác nhận điểm đón tại địa điểm phức tạp

```text
QUICK PROBLEM CARD #1

Bài toán: Khách ghim điểm đón trong ngõ sâu hoặc địa điểm có nhiều cổng, trong khi ô tô khó tiếp cận hoặc quay đầu dù bản đồ vẫn cho phép route.
Công ty thành viên: [x] Xanh SM

Ai đang đau? Khách hàng (chờ đợi, lỡ chuyến), tài xế (mất thời gian, mất cuốc), điều phối/CSKH (nhận cuộc gọi hỗ trợ).

Workflow thủ công hiện tại:
1. Khách đặt xe theo vị trí GPS hoặc ghim điểm sâu trong ngõ
2. Hệ thống bản đồ route xe vào ngõ nhưng không đánh giá tốt độ rộng đường, chỗ quay đầu hoặc khả năng đón xe
3. Tài xế đến gần nơi đón, không thể vào/ngang qua, rồi gọi/chat với khách để mô tả mốc địa điểm
4. Khách đi bộ tìm xe hoặc đổi điểm đón thủ công; nếu vẫn không gặp nhau, khách hoặc tài xế hủy chuyến

Bước tốn thời gian/lỗi nhất: Bước 2-3 (trung bình 5-10 phút, bản đồ không phản ánh đầy đủ khả năng tiếp cận bằng ô tô và hai bên dễ hiểu nhầm mốc/sảnh).
AI hỗ trợ: Kết hợp rule-based map layer (độ rộng đường, hướng cấm, chỗ quay đầu, lịch sử xe từng tiếp cận) với LLM đọc chat/ghi âm ngắn. Hệ thống gợi ý một "điểm đón an toàn" như đầu ngõ, cổng gần nhất hoặc điểm quay đầu phù hợp, rồi tạo tin nhắn nháp để khách và tài xế xác nhận.

Metric: Giảm 20% tỷ lệ hủy chuyến do không tìm thấy điểm đón/không tiếp cận được điểm ghim; giảm thời gian xác nhận điểm đón từ 7 phút xuống dưới 2 phút; tỷ lệ điểm đón gợi ý được cả hai bên xác nhận đạt trên 85%.

Quick Architecture: [ ] No AI  [x] Rule  [x] LLM  [ ] Agent
Boundary: AI chỉ tạo bản nháp gợi ý; không tự đổi điểm đón hoặc tự gửi tin nhắn khi chưa có xác nhận của khách và tài xế. Khi map data không đủ tin cậy, hệ thống phải hiển thị vị trí ghim ban đầu và chuyển sang liên lạc/điều phối theo quy trình hiện có.
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
