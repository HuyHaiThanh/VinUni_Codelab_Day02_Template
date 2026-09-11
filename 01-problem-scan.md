**Tên nhóm:** [Tự điền]

**Họ và tên:** Nguyễn Văn Huy

**Email đăng ký:** huyhaithanh51@gmail.com

# Lab 02 — Problem Scan & Quick Problem Cards

**Phạm vi:** Bài làm cá nhân — Phase 1 và Phase 2 theo README.

> Các quy trình và thời gian dưới đây là giả định cần khảo sát; các metric là mục tiêu thử nghiệm, chưa phải kết quả đạt được. Đề tài ưu tiên là hỗ trợ người tìm thuê chỗ ở tại Vinhomes. Đây là đề xuất học tập, không khẳng định Vinhomes đang cung cấp chatbot này; chưa bao gồm mua bán bất động sản.

## Phase 1 — SCAN: 6 bài toán chọn lọc

| # | Subsidiary / Bối cảnh | Lens | Mô tả ngắn bài toán |
|---|---|---|---|
| 1 | **Vinhomes — hỗ trợ người tìm thuê chỗ ở** | **Tốn thời gian** | Cá nhân, cặp đôi hoặc gia đình muốn thuê căn hộ phải đọc nhiều tin rời rạc, hỏi lại giá, phí quản lý, nội thất và tình trạng bàn giao; khó so sánh các căn đáp ứng ngân sách và ngày chuyển vào. |
| 2 | Xanh SM | Pain từ người khác | Khách và tài xế mô tả đồ thất lạc khác nhau, khiến nhân viên hỗ trợ mất thời gian đối chiếu báo cáo để tìm đồ và xác minh. |
| 3 | VinUni — phòng đào tạo | Lặp lại | Nhân viên đọc email sinh viên, phân loại yêu cầu và hỏi bổ sung thông tin còn thiếu trước khi chuyển người xử lý. |
| 4 | VinFast — mua hàng | Tốn thời gian | Nhân viên phải đọc chuỗi email nhà cung cấp để phát hiện thay đổi lịch giao linh kiện, dễ bỏ sót cập nhật hoặc nhầm lịch đề xuất với lịch đã xác nhận. |
| 5 | Vinhomes — ban quản lý | Lặp lại | Nhân viên phải chuyển biên bản họp thành công việc, người phụ trách và hạn hoàn thành; các cam kết rải rác dễ bị bỏ sót khi theo dõi. |
| 6 | Vinpearl — bàn giao phục vụ khách | AI có thể tốt hơn | Yêu cầu đặc biệt của khách nằm trong nhiều ghi chú, khiến các bộ phận khó nhận đúng phần việc của mình và biết yêu cầu nào chưa được xác nhận. |

## Phase 2 — 3 Quick Problem Cards

### Card #1 — Chatbot tìm thuê căn hộ Vinhomes (ưu tiên)

| Trường | Nội dung |
|---|---|
| **Bài toán** | Giúp người tìm thuê lập danh sách căn hộ đáp ứng nhu cầu và nhận biết thông tin cần xác minh trước khi liên hệ xem căn hộ. |
| **Đơn vị / Actor** | Vinhomes; người dùng chính là cá nhân, cặp đôi hoặc gia đình tìm thuê căn hộ để ở. |
| **Workflow hiện tại — giả định** | 1. Xác định ngân sách và nhu cầu → 2. Tìm tin trên nhiều nguồn → 3. Hỏi giá, phí, vị trí và tình trạng căn hộ → 4. So sánh, chọn danh sách ngắn → 5. Liên hệ xác minh và hẹn xem. |
| **Bottleneck — giả định** | Bước 2–4: khoảng **45 phút/phiên tìm kiếm** để đọc tin và so sánh; chưa tính thời gian chờ chủ nhà/môi giới phản hồi hoặc đi xem căn hộ. |
| **AI hỗ trợ** | Hỏi rõ nhu cầu bằng hội thoại; chuyển thành tiêu chí tìm kiếm; giải thích tối đa 3 căn hộ phù hợp từ dữ liệu có sẵn, kèm giá/phí, nguồn tin và thông tin còn thiếu. |
| **Metric mục tiêu** | Giảm thời gian lập danh sách ngắn từ **45 xuống ≤15 phút/phiên**; **≥90% tình huống có căn hộ phù hợp** trả về ít nhất một căn hộ đúng trong top 3; **100% căn hộ được gắn nhãn “đáp ứng”** phải thỏa các điều kiện bắt buộc trên bộ thử. |
| **Quick Architecture** | **LLM Feature + bộ lọc theo quy tắc**. LLM hiểu nhu cầu và giải thích; code lọc ngân sách, vị trí, ngày vào ở và các điều kiện bắt buộc. |

**Phạm vi prototype:** Một khu đô thị Vinhomes được chọn, khoảng 30 tin căn hộ giả lập hoặc được phép sử dụng. Mỗi tin có mã căn hộ, giá thuê, phí bắt buộc đã biết, khu vực, khoảng cách nếu có nguồn, tiện ích, ngày có thể vào ở, nguồn và ngày cập nhật. Chatbot chỉ hỗ trợ chọn căn hộ để người dùng kiểm tra tiếp.

**Ví dụ nhu cầu:** “Mình cần căn hộ dưới 12 triệu/tháng tính cả phí cố định, ở một mình, trong phạm vi 3 km từ mốc tiện ích tham chiếu của khu đô thị, vào ở đầu tháng sau; ưu tiên có cửa sổ.” Chatbot cần xác nhận ngày chuyển vào cụ thể và phân biệt điều kiện bắt buộc với ưu tiên có thể linh hoạt.

**Ranh giới và fallback:**

- Chỉ đề xuất căn hộ có mã và nguồn trong dữ liệu. Không bịa căn hộ, giá, khoảng cách, tiện ích hoặc khẳng định tin còn hiệu lực khi chưa xác minh.
- Thiếu phí thì ghi “chưa đủ dữ liệu xác nhận ngân sách”; chi phí điện/nước theo sử dụng phải tách khỏi tổng phí cố định. Không gọi một mức giá chưa đầy đủ là “trọn gói”.
- Không tự nới ngân sách hoặc điều kiện bắt buộc. Nếu không có kết quả, thông báo rõ và hỏi người dùng muốn điều chỉnh tiêu chí nào.
- Không khẳng định căn hộ an toàn hoặc chủ nhà/môi giới uy tín chỉ từ nội dung tin; không tự đặt cọc, đặt căn hộ hoặc liên hệ chủ nhà/môi giới. Người dùng xác minh và quyết định.

**Kiểm chứng dự kiến:** 20 tình huống có đáp án chuẩn: 12 có căn hộ đáp ứng, 4 không có kết quả, 4 thiếu/mâu thuẫn thông tin. Kiểm tra riêng việc hỏi lại, xử lý tin cũ, phí thiếu và yêu cầu vượt ngân sách. So sánh thời gian với bộ lọc thông thường trên cùng dữ liệu; không tính thời gian thu thập tin vào riêng một phương án.

**AI Fit cần chứng minh:** Nếu người dùng chỉ lọc giá và vị trí, bộ lọc thông thường có thể đủ. Lợi ích cần thử của chatbot là hiểu yêu cầu diễn đạt tự nhiên, hỏi đúng thông tin thiếu và giải thích sự phù hợp. Dữ liệu căn hộ đáng tin và được cập nhật là phụ thuộc chính.

### Card #2 — Đối chiếu đồ thất lạc Xanh SM

| Trường | Nội dung |
|---|---|
| **Bài toán / Actor** | Nhân viên hỗ trợ cần tìm báo cáo đồ tìm thấy khớp với mô tả đồ mất của khách. |
| **Workflow hiện tại — giả định** | 1. Nhận báo cáo → 2. Lọc theo chuyến/ngày → 3. So sánh mô tả → 4. Xác minh với các bên → 5. Ghi nhận kết quả. |
| **Bottleneck — giả định** | Bước 2–3 mất **10 phút/yêu cầu** do mô tả không thống nhất hoặc thiếu đặc điểm. |
| **AI hỗ trợ** | Trích xuất thuộc tính, gợi ý tối đa 3 báo cáo có khả năng khớp và chỉ rõ điểm giống/mâu thuẫn. |
| **Metric mục tiêu** | Giảm thời gian tìm và đối chiếu xuống **≤4 phút/yêu cầu**, gồm review; bản ghi đúng xuất hiện trong top 3 ở **≥90% yêu cầu có cặp khớp**. |
| **Quick Architecture** | **Rule + LLM Feature**: lọc theo chuyến/ngày rồi so khớp mô tả. |
| **Ranh giới / Fallback** | Không xác nhận quyền sở hữu hay tự trả đồ; không tiết lộ thông tin người khác. Thiếu căn cứ thì chuyển nhân viên xác minh. |
| **Dữ liệu thử** | 30 báo cáo đồ tìm thấy và 20 yêu cầu giả lập: 12 có cặp khớp, 8 không có. Theo dõi riêng gợi ý sai ở nhóm không có cặp khớp. |

**Điểm cần xác minh:** Nếu mã chuyến đã đủ để tìm đồ, tra cứu thông thường có thể giải quyết phần lớn bài toán.

### Card #3 — Tiếp nhận email phòng đào tạo VinUni

| Trường | Nội dung |
|---|---|
| **Bài toán / Actor** | Nhân viên phòng đào tạo cần phân loại email và phát hiện thông tin thiếu để giảm các lượt hỏi lại. |
| **Workflow hiện tại — giả định** | 1. Nhận email → 2. Phân loại → 3. Kiểm tra checklist → 4. Soạn yêu cầu bổ sung hoặc chuyển bộ phận → 5. Review và gửi. |
| **Bottleneck — giả định** | Bước 2–4 mất **6 phút/email** vì nội dung viết tự do, thiếu thông tin hoặc có nhiều yêu cầu. |
| **AI hỗ trợ** | Trích xuất nội dung, đề xuất loại yêu cầu và soạn nháp câu hỏi bổ sung dựa trên checklist. |
| **Metric mục tiêu** | Giảm thời gian xử lý xuống **≤2 phút/email**, gồm review; phân loại đúng **≥90% email một yêu cầu trong phạm vi** và phát hiện **≥95% trường bắt buộc bị thiếu**. |
| **Quick Architecture** | **LLM Feature + Rule**: LLM hiểu email, rule kiểm tra trường bắt buộc theo loại yêu cầu. |
| **Ranh giới / Fallback** | Không phê duyệt yêu cầu, sửa dữ liệu học tập hoặc tự gửi thư. Email ngoài phạm vi, nhiều yêu cầu hoặc mâu thuẫn chuyển nhân viên xử lý. |
| **Dữ liệu thử** | 30 email giả lập: 24 email thuộc ba nhóm đăng ký/hủy học phần, xác nhận sinh viên, hỏi kết quả học tập; 6 email nhiều yêu cầu/ngoài phạm vi. Checklist là minh họa cần xác nhận. |

**Điểm cần xác minh:** So sánh với biểu mẫu có trường bắt buộc; theo dõi cả số lần hỏi lại thông tin đã có để tránh hỏi thừa.

## Hướng ưu tiên cho Phase 3

**Chọn hướng chatbot tìm chỗ ở tại Vinhomes để phân tích sâu**, theo ưu tiên cá nhân hiện tại. Đề tài tập trung vào chọn phòng theo nhu cầu và minh bạch thông tin còn thiếu, khác các đề tài mẫu về thủ tục cư dân và đặt phòng khách sạn.

Trước khi kết luận GO, cần phỏng vấn người đang tìm thuê căn hộ tại Vinhomes về cách tìm và so sánh tin, xác minh nguồn dữ liệu có thể dùng và đo baseline. Prototype ban đầu dùng dữ liệu giới hạn, kiểm tra chất lượng gợi ý trước khi mở rộng nguồn tin.
