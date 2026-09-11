**Tên nhóm:** [Tự điền]

**Họ và tên:** [Tự điền]

**Email đăng ký:** [Tự điền]

# AI Log & Reflection — Bài làm cá nhân

> Bản ghi do AI hỗ trợ soạn từ cuộc trao đổi thực tế. Người nộp cần đọc lại và điều chỉnh giọng văn trước khi nộp. Không ghi nhận phỏng vấn, họp nhóm hoặc lần chạy model chưa diễn ra.

## 1. AI đã hỗ trợ gì?

| Yêu cầu thực tế | Hỗ trợ của AI | Điều chỉnh của người học |
|---|---|---|
| Đọc dự án và phân chia việc cá nhân/nhóm | Đọc README, worksheet, code mẫu và autograder; giải thích các file cần nộp | Yêu cầu gợi ý bài toán và viết Quick Cards |
| Gợi ý Phase 1 từ file 02 và 03 | Tạo danh sách bài toán theo lenses | Yêu cầu hạn chế trùng đề tài trong tài liệu có sẵn |
| Hoàn thiện Problem Scan | Tạo 12 bài toán và 3 cards | Nhận xét “nhiều quá”, yêu cầu rút còn 5–6 và ưu tiên chatbot tìm trọ |
| Hoàn thành lab theo slide | Đọc bản xuất văn bản của slide; bổ sung báo cáo, workflow, prototype và test | Yêu cầu làm bài cá nhân, để thông tin thành viên tự điền |

## 2. AI sai hoặc cần được sửa ở đâu?

**Gợi ý ban đầu thiếu tập trung.** Danh sách dài và nhiều đề tài trùng file mẫu chưa đáp ứng nhu cầu lựa chọn. Người học thu hẹp yêu cầu về tính khác biệt, số lượng và chủ đề. Bản cuối giữ 6 bài toán, 3 cards, ưu tiên tìm trọ.

**Số liệu chưa có bằng chứng.** Thời gian 45 phút tìm kiếm và mục tiêu 15 phút chỉ là giả định scoping. Báo cáo gắn nhãn rõ và dùng quyết định NOT YET, không viết như khảo sát doanh nghiệp hoặc kết quả cải thiện thật.

**Môi trường ban đầu chưa khớp slide.** Lần đầu tạo venv dùng Python 3.14.7, trong khi slide yêu cầu >3.11 và <3.14. Sau khi đọc slide đã tạo `.venv-lab` với Python 3.13.13 và cài dependencies. Môi trường cũ vẫn tồn tại; lệnh chạy bài dùng `.venv-lab`.

**Autograder có giới hạn.** Kiểm tra từ khóa “Passed” hoặc thẻ xuất hiện bất kỳ vị trí nào chưa đủ chứng minh ranh giới. Code mới kiểm tra prefix đầu chuỗi, JSON, action và human approval; không sửa đầu ra model để biến lỗi thành pass. Kiểm tra reason tự do vẫn cần con người đọc.

## 3. Cách điều chỉnh prompt và ranh giới

- Chuyển từ “gợi ý nhiều bài toán” sang 6 bài có actor và bottleneck rõ, ưu tiên tìm trọ cho sinh viên.
- Tách **giá thuê + phí cố định đã biết** khỏi điện/nước theo sử dụng; phí thiếu không được coi là 0.
- LLM chỉ trích xuất nhu cầu; người dùng xác nhận, sau đó rule lọc và dựng kết quả từ danh mục có sẵn. Không để model tự bịa phòng hoặc tự thay ngân sách.
- Bài Xanh SM theo slide vẫn có riêng system instruction và 4 tình huống tấn công; không dùng prompt tìm trọ để thay yêu cầu code bắt buộc.

## 4. Kết quả đã quan sát

| Kiểm tra | Kết quả / Giới hạn |
|---|---|
| Kiểm thử cục bộ | 23 test rule/validator đạt. Đây là test code, không phải 23 lần gọi Gemini. |
| Demo tìm trọ | Với dữ liệu giả lập ngày 2026-09-11, ngân sách 4 triệu, khoảng cách 3 km, vào ở 2026-10-01: trả ROOM-09, ROOM-01, ROOM-02. Tổng cố định tương ứng 2.950.000; 3.050.000; 3.400.000 VND/tháng. |
| Sơ đồ PNG | Đã xuất và xem ảnh: đủ 5 bước, handoff, bottleneck, thời gian và ghi chú giả định. |
| Autograder | **8/10 kiểm tra tự động:** đủ 4 file và đạt 3 kiểm tra cấu trúc code. Hai tiêu chí chạy API/đầu ra live chưa đạt do thiếu key. Đây không phải điểm giảng viên chấm nội dung. |
| Gemini trực tiếp | **Chưa chạy được:** môi trường chưa có GEMINI_API_KEY/GOOGLE_API_KEY. Script báo chưa chạy và trả exit code 2; không thay bằng mock hoặc tự ghi Passed. |
| Đánh giá người dùng | Chưa khảo sát, chưa đo thời gian 45→15 phút và chưa chạy bộ 20 tình huống pilot. |

Log kiểm tra tự động nằm trong `validation/`. Sau khi cấu hình key, cần chạy lại bài Gemini và cập nhật mục này bằng output thật, kể cả khi mô hình vi phạm ranh giới.

## 5. Bài học rút ra

AI hữu ích để tổ chức ý tưởng và tạo bản nháp có cấu trúc, nhưng đề tài tốt cần người học giới hạn phạm vi. Với tìm trọ, chất lượng dữ liệu và việc kiểm tra phí quan trọng không kém prompt. Kết quả unit test chứng minh các quy tắc cụ thể hoạt động trên dữ liệu thử; chưa chứng minh chatbot đáng tin trong vận hành. Chỉ nên nâng quyết định NOT YET sau khi có bằng chứng dữ liệu, stakeholder và thử nghiệm thực tế.
