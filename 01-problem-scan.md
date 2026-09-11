# Problem Scan — Vin Smart Future
**Tên nhóm:** [Tự điền]

**Họ và tên:** Nguyễn Đỗ Chiến Thắng

**Mã HV:** 2A202602442

**Email đăng ký:** nguyendochienthang711@gmail.com


> **Lựa chọn của nhóm cho các phase tiếp theo:** Vinhomes — hỗ trợ người tìm thuê chỗ ở so sánh các căn đáp ứng ngân sách, nhu cầu và ngày chuyển vào. Đề tài này thay thế các phương án ưu tiên thử nghiệm ban đầu bên dưới khi thực hiện Deep-Dive, Prototype và Evaluate.

## Phase 1 — SCAN: Danh sách cơ hội AI

Các cơ hội dưới đây được tạo từ bốn lenses: tác vụ lặp lại, tốn thời gian, AI-upgrade và pain từ stakeholder. Chúng là giả định scoping ban đầu cho bài lab; workflow và metric cần được xác minh với đội vận hành trước khi triển khai.

| # | Công ty thành viên | Lens | Mô tả ngắn bài toán |
|---:|---|---|---|
| 1 | VinFast | Lặp lại (Repetitive) | Cố vấn hậu mãi phải đọc và đối chiếu lịch sử sửa chữa, cảnh báo xe, chứng từ và chính sách bảo hành cho từng yêu cầu. AI có thể trích xuất dữ kiện, phát hiện hồ sơ thiếu và tạo bản tóm tắt để nhân viên kiểm tra. |
| 2 | Xanh SM (GSM) | Pain từ stakeholder | Điểm đón ghim sai, đường cấm hoặc thay đổi nhu cầu giờ cao điểm khiến tài xế/điều phối viên phải gọi xác minh thủ công, làm chậm ghép cuốc và tăng hủy chuyến. |
| 3 | Vinhomes | Tốn thời gian | Phản ánh của cư dân từ app, hotline và email cần được đọc, tìm vị trí, phân loại mức khẩn và chuyển ticket thủ công; sai sót có thể làm trễ SLA. |
| 4 | Vinmec | AI-upgrade | Tổng đài phải trả lời lặp lại câu hỏi hành chính và thu thập thông tin đặt lịch; khách hàng có thể chờ lâu, trong khi các câu hỏi y khoa phải được chuyển đúng người phụ trách. |
| 5 | Vinpearl / VinWonders | Tốn thời gian | Đội CSKH phải tổng hợp, dịch, phân loại và soạn phản hồi cho đánh giá từ nhiều kênh; các phản hồi có tín hiệu an toàn hoặc tiêu cực cần được ưu tiên nhanh. |

## Phase 2 — QUICK-ASSESS: Ba bài toán ưu tiên

### Card 1 — VinFast: Tóm tắt và kiểm tra hồ sơ hậu mãi

| Hạng mục | Nội dung |
|---|---|
| **Bài toán** | Giảm thời gian cố vấn dịch vụ đọc và đối chiếu hồ sơ bảo hành/sửa chữa trước khi phản hồi yêu cầu hậu mãi. |
| **Actor** | Cố vấn dịch vụ, nhân viên bảo hành và khách hàng chờ phản hồi. |
| **Workflow hiện tại** | Khách gửi yêu cầu → cố vấn tìm VIN/lịch sử trên nhiều hệ thống → đối chiếu chính sách, hóa đơn và mã lỗi → yêu cầu bổ sung chứng từ → soạn phản hồi và trình duyệt. |
| **Bottleneck** | Tìm và đối chiếu dữ liệu phân tán ở bước 2–3; giả định 10–15 phút/yêu cầu, dễ bỏ sót hồ sơ hoặc áp sai điều khoản. |
| **AI hỗ trợ** | Trích xuất dữ kiện, tóm tắt lịch sử, nêu chứng từ thiếu và tạo nháp phản hồi. Nhân viên xác nhận toàn bộ kết luận bảo hành. |
| **Metric đề xuất** | Median handling time từ 12 xuống ≤6 phút/yêu cầu; ≥85% bản tóm tắt được chấp nhận sau chỉnh sửa nhỏ; tỷ lệ phản hồi sai không tăng so với baseline. |
| **Kiến trúc & boundary** | LLM + truy xuất dữ liệu được phân quyền; rule kiểm tra điều kiện bắt buộc; human-in-the-loop phê duyệt. AI không tự quyết định chấp nhận/từ chối bảo hành. |

### Card 4 — Vinmec: Trợ lý tiếp nhận nhu cầu đặt lịch

| Hạng mục | Nội dung |
|---|---|
| **Bài toán** | Hỗ trợ tổng đài trả lời câu hỏi hành chính và thu thập thông tin đặt lịch nhất quán trước khi nhân viên xác nhận lịch. |
| **Actor** | Khách hàng, nhân viên tổng đài/điều phối lịch hẹn và lễ tân. |
| **Workflow hiện tại** | Khách gọi/nhắn tin → nhân viên hỏi nhu cầu, chuyên khoa, cơ sở, thời gian → tra thông tin hành chính/khung giờ → nhập yêu cầu → xác nhận hoặc chuyển bác sĩ khi có câu hỏi y khoa. |
| **Bottleneck** | Hỏi lặp lại và nhập dữ liệu ở bước 2–4; giả định 5–8 phút/yêu cầu, có nguy cơ thiếu thông tin hoặc nhầm cơ sở/chuyên khoa. |
| **AI hỗ trợ** | Hỏi theo biểu mẫu, trả lời từ knowledge base hành chính đã duyệt, tóm tắt yêu cầu và tạo phiếu nháp. |
| **Metric đề xuất** | ≥70% yêu cầu đủ thông tin ngay lần tiếp nhận đầu; thời gian tạo phiếu từ 6 xuống ≤2 phút; 100% câu hỏi y khoa/khẩn cấp được chuyển tuyến. |
| **Kiến trúc & boundary** | LLM có guardrails + rule-based triage + knowledge base đã duyệt; nhân viên xác nhận lịch. AI không chẩn đoán, kê đơn, tư vấn điều trị hay xử lý ca khẩn cấp. |

### Card 5 — Vinpearl/VinWonders: Phân loại phản hồi sau trải nghiệm

| Hạng mục | Nội dung |
|---|---|
| **Bài toán** | Tự động tổng hợp, phân loại và soạn nháp phản hồi cho đánh giá sau lưu trú/vui chơi, để CSKH ưu tiên đúng phản hồi tiêu cực. |
| **Actor** | Nhân viên CSKH, quản lý vận hành tại cơ sở và khách hàng phản hồi qua OTA, app, email hoặc mạng xã hội. |
| **Workflow hiện tại** | Thu thập đánh giá → dịch/đọc và nhận diện chủ đề → gắn nhãn mức độ, cơ sở, bộ phận phụ trách → chuyển ticket → soạn và duyệt phản hồi. |
| **Bottleneck** | Đọc đánh giá tự do, đa ngôn ngữ và phân loại thủ công ở bước 2–3; giả định 3–5 phút/đánh giá, có nguy cơ bỏ sót case nghiêm trọng. |
| **AI hỗ trợ** | Dịch/tóm tắt, gán chủ đề, chấm mức khẩn và soạn nháp theo giọng điệu thương hiệu; rule ưu tiên tín hiệu an toàn/khủng hoảng. |
| **Metric đề xuất** | ≥90% đánh giá được phân loại trong <30 giây; ≥95% case có tín hiệu an toàn được chuyển đúng bộ phận trong 5 phút; thời gian soạn nháp từ 4 xuống ≤1,5 phút. |
| **Kiến trúc & boundary** | LLM classification/drafting + rule-based routing/escalation; quản lý duyệt toàn bộ phản hồi trước khi gửi. AI không tự gửi phản hồi hoặc đưa ra cam kết bồi thường. |

## Nhận định sơ bộ

Trong ba phương án, bài toán Vinpearl/VinWonders là ứng viên thuận lợi để prototype trước vì đầu vào là văn bản, đầu ra có thể kiểm tra bằng nhãn/chủ đề, và quyết định cuối vẫn có người duyệt. Vinmec có tác động trải nghiệm khách hàng rõ rệt nhưng cần ranh giới an toàn nghiêm ngặt; VinFast cần xác minh khả năng truy xuất dữ liệu và quyền truy cập trước khi đánh giá tính khả thi.
