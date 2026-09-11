# Nhật ký tương tác AI (AI Log)

**Tên Nhóm:** Group 1
**Họ tên thành viên:** Đinh Trường An
**Email:** dinhtruongan@example.com

---

## 1. AI đã hỗ trợ tôi những gì trong bài Lab này?

Trong Lab 02, tôi sử dụng AI như một thought-partner để chuyển từ các ý tưởng vận hành chung chung sang pain point mà người dùng có thể gặp trực tiếp.

1. **Tìm và làm rõ bài toán điểm đón Xanh SM:** Ban đầu tôi chỉ nghĩ đến việc khách và tài xế không tìm thấy nhau ở nơi nhiều cổng. AI giúp tôi mở rộng tình huống sát thực tế hơn: tại Việt Nam có nhiều ngõ sâu mà bản đồ vẫn cho phép route, nhưng ô tô khó đi vào hoặc không có chỗ quay đầu. Tôi dùng AI để xác định workflow hiện tại, các bên liên quan và bottleneck giữa bước map route với lúc tài xế phải gọi cho khách.

2. **Thiết kế giải pháp có kết hợp Rule và LLM:** AI gợi ý tách phần nào nên dùng dữ liệu có cấu trúc và phần nào cần hiểu ngôn ngữ. Rule-based map layer dùng dữ liệu về độ rộng đường, hướng cấm, chỗ quay đầu và lịch sử xe từng tiếp cận; LLM chỉ dùng để hiểu chat/ghi âm ngắn và tạo tin nhắn nháp gợi ý điểm đón an toàn ở đầu ngõ hoặc cổng gần nhất.

3. **Stress-test ý tưởng đánh giá rủi ro lái xe:** Khi đề xuất dùng dữ liệu GPS/telemetry để phát hiện phanh gấp, tăng tốc gấp hoặc chạy quá tốc độ, tôi nhờ AI phản biện rủi ro về công bằng với tài xế. Điều này giúp tôi đổi mục tiêu từ "AI chấm điểm để phạt" sang "AI gắn cờ rủi ro để quản lý xem xét và hỗ trợ đào tạo".

4. **Viết metric và operational boundary:** AI hỗ trợ biến ý tưởng thành metric đo được, ví dụ giảm tỷ lệ hủy chuyến do không tiếp cận được điểm ghim và giảm thời gian xác nhận điểm đón. AI cũng giúp tôi xác định các boundary: không tự đổi điểm đón, không tự gửi tin nhắn, không tự phạt hoặc giảm thu nhập tài xế.

## 2. AI sai/hallucination ở đâu?

Trong quá trình brainstorm, AI có các đề xuất nghe hợp lý nhưng nếu áp dụng ngay sẽ không thực tế hoặc không công bằng:

- **Đánh giá quá cao dữ liệu bản đồ:** AI từng giả định hệ thống bản đồ luôn biết chính xác độ rộng ngõ, chỗ quay đầu và khả năng ô tô đi vào. Thực tế dữ liệu có thể cũ, thiếu hoặc thay đổi do công trình, xe đỗ. Nếu tin hoàn toàn vào gợi ý này, tài xế vẫn có thể bị dẫn vào điểm khó tiếp cận.

- **Tự động thay đổi điểm đón:** AI từng gợi ý hệ thống tự chuyển pin của khách ra đầu ngõ để giảm thời gian chờ. Điều này có thể khiến khách phải đi bộ xa, qua đường không an toàn hoặc bỏ lỡ xe. Đây là quyết định ảnh hưởng trực tiếp đến trải nghiệm nên không thể tự động hóa hoàn toàn.

- **Dùng điểm lái xe làm căn cứ phạt ngay:** AI ban đầu xem một điểm rủi ro thấp là bằng chứng đủ để phạt tài xế. Cách làm này không xét đến bối cảnh như tắc đường, ổ gà, tình huống tránh va chạm, lỗi GPS hoặc thiết bị. Nó có thể tạo ra quyết định thiếu công bằng.

## 3. Tôi đã sửa prompt/ranh giới ra sao?

Sau khi phản biện các lỗi trên, tôi xác định các ranh giới vận hành rõ hơn cho giải pháp:

- **Xác nhận hai chiều cho điểm đón:** AI chỉ tạo bản nháp gợi ý điểm đón an toàn, nêu lý do và mức độ tin cậy. Điểm đón chỉ thay đổi khi cả khách và tài xế xác nhận. Nếu dữ liệu không đủ tin cậy, hệ thống giữ điểm ghim ban đầu và chuyển sang quy trình gọi/chat hoặc điều phối hiện có.

- **Không xem AI là nguồn dữ liệu duy nhất:** Gợi ý điểm đón phải dựa trên dữ liệu map đã xác thực, lịch sử tiếp cận và phản hồi thực tế. AI không được khẳng định một con ngõ "chắc chắn đi được" nếu không có dữ liệu đủ mạnh.

- **Human-in-the-loop cho đánh giá lái xe:** Điểm rủi ro chỉ là tín hiệu để quản lý ưu tiên xem xét. Quản lý phải xem dữ liệu gốc, kiểm tra bối cảnh và cho tài xế cơ chế giải trình trước khi nhắc nhở, đào tạo hoặc áp dụng bất kỳ biện pháp nào.

- **Tách Rule và LLM:** Các điều kiện an toàn có thể kiểm chứng phải được đặt bằng rule rõ ràng. LLM chỉ dùng cho phần tóm tắt dữ liệu và soạn nháp giao tiếp; không được tự thực hiện hành động ảnh hưởng đến khách hoặc tài xế.
