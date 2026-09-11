# Deep-Dive Report — Vinhomes Rental Match Assistant

## 1. Problem statement

**Bài toán nhóm chọn:** hỗ trợ cá nhân, cặp đôi hoặc gia đình đang tìm thuê căn hộ Vinhomes so sánh nhanh các căn còn khả dụng theo ngân sách, vị trí/tòa, số phòng ngủ, nội thất, diện tích và ngày có thể chuyển vào.

Phạm vi pilot chỉ là tạo **shortlist dạng nháp** từ dữ liệu listing đã được Vinhomes/phòng kinh doanh phê duyệt. Đây không phải công cụ quyết định cấp căn, phê duyệt hồ sơ, báo giá cuối cùng hay đàm phán với khách.

| Field | Nội dung chi tiết |
|---|---|
| **1. Actor / Operator** | Nhân viên tư vấn cho thuê hoặc sales admin; người thuê là người nhận kết quả và quyết định xem căn. |
| **2. Current Workflow** | Khách gửi nhu cầu qua chat/điện thoại; tư vấn viên hỏi lại ngân sách, khu vực, số người, phòng ngủ, nội thất và ngày chuyển vào; mở bảng listing/nhóm chat để lọc căn; gọi/chờ chủ nhà xác nhận; gửi một số căn bằng tin nhắn rồi trả lời các câu hỏi so sánh. |
| **3. Bottleneck** | Nhu cầu thường là văn bản tự do và thiếu trường; dữ liệu căn nằm ở nhiều bảng/nhóm, tình trạng trống thay đổi nhanh. Việc lọc, hỏi bổ sung và so sánh thủ công dễ gửi căn vượt ngân sách, đã có người giữ chỗ hoặc không kịp ngày chuyển vào. |
| **4. Business Impact** | Giả định cần xác minh bằng log: một tư vấn viên mất khoảng 15–20 phút để tạo shortlist đầu tiên và phải trao đổi 2–3 lượt để đủ tiêu chí. Trễ phản hồi có thể làm giảm tỷ lệ đặt lịch xem căn và tăng tải cho đội tư vấn. |
| **5. Success Metric** | Pilot đặt mục tiêu: (a) ≥80% yêu cầu có shortlist nháp trong ≤3 phút sau khi đủ dữ liệu; (b) ≥90% căn gợi ý thỏa hard filters đã xác nhận; (c) giảm thời gian chuẩn bị shortlist trung vị từ baseline xuống ít nhất 50%; (d) 100% kết quả hiển thị nhãn “cần nhân viên xác minh tình trạng/cập nhật giá”. |
| **6. Operational Boundary** | AI chỉ trích xuất nhu cầu, hỏi trường còn thiếu, lọc/ranking từ inventory được phân quyền và tạo nháp so sánh. AI không được bịa listing, giá, ưu đãi hay tình trạng trống; không tự đặt lịch, giữ căn, gửi cam kết, quyết định mức giá/điều kiện hợp đồng; không suy luận hoặc xếp hạng theo thuộc tính nhạy cảm (dân tộc, tôn giáo, giới tính, tình trạng hôn nhân, sức khỏe...) và không dùng dữ liệu cá nhân ngoài mục đích tìm căn. Nhân viên xác minh inventory và phê duyệt trước khi gửi khách. |

## 2. Current-state workflow

```text
Khách gửi nhu cầu tự do
        │  (chat / điện thoại)
        ▼
Tư vấn viên hỏi lại tiêu chí ───── 🔴 4–7 phút; dễ thiếu ngày chuyển vào/ngân sách
        │
        ▼
Mở nhiều nguồn listing và lọc thủ công ─ 🔴 6–10 phút; dữ liệu có thể cũ/khác nhau
        │
        ├── 🔄 Handoff: hỏi chủ nhà/quản lý về giá và tình trạng thực
        ▼
Tư vấn viên so sánh, soạn shortlist ─── 🔴 4–6 phút; khó giải thích trade-off nhất quán
        │
        ▼
Nhân viên gửi khách và hẹn xem căn

Tổng thời gian giả định: 15–25 phút/yêu cầu, chưa tính thời gian chờ xác nhận.
```

**Dữ liệu cần có trước pilot:** inventory được chuẩn hóa (mã căn, dự án/tòa, diện tích, phòng ngủ, nội thất, giá, phí, ngày khả dụng, trạng thái, thời điểm cập nhật); knowledge base chính sách đã duyệt; log yêu cầu đã ẩn danh để đo baseline. Giá và trạng thái phải có `last_updated_at` để phát hiện dữ liệu cũ.

## 3. AI Fit và future-state flow

### Quyết định AI Fit

Giải pháp là **LLM feature + rule-based retrieval/filtering**, không phải agent tự trị.

- Rule-based xử lý hard filters: ngân sách tối đa, số phòng ngủ tối thiểu, ngày có thể chuyển vào, trạng thái khả dụng và quyền truy cập dữ liệu.
- LLM xử lý câu mô tả tự do, hỏi làm rõ khi thiếu dữ liệu, giải thích trade-off và viết bản so sánh dễ đọc.
- Con người xác minh mọi thuộc tính biến động (giá, khả dụng, ưu đãi) trước khi gửi ra ngoài.

```text
Khách nhập nhu cầu
        ▼
🔵 AI trích xuất tiêu chí + hỏi lại trường thiếu
        ▼
Rule engine kiểm tra hard filters trên inventory được phân quyền
        ├── Không có kết quả / dữ liệu cũ → ↩️ Fallback: yêu cầu tư vấn viên tìm thủ công
        ▼
🔵 AI tạo shortlist 3–5 căn, nêu nguồn dữ liệu và trade-off
        ▼
🟢 Tư vấn viên kiểm tra giá, tình trạng, fairness và nội dung
        ├── Sai/thiếu → sửa hoặc lọc thủ công, ghi feedback
        ▼
Gửi shortlist có nhãn “đã xác minh lúc ...” cho khách
```

## 4. Prototype prompt và kiểm thử ranh giới

Prototype nằm tại `starter-code/prompt_prototype.py`. Nó yêu cầu JSON có nhãn `[DRAFT_ONLY]`, chỉ tạo shortlist khi có dữ liệu listing được cung cấp và buộc nêu các trường cần tư vấn viên xác minh.

Ba adversarial tests kiểm tra: yêu cầu bịa căn/gửi thẳng cho khách; yêu cầu đưa thuộc tính nhạy cảm vào ranking; và yêu cầu cam kết giá hoặc giữ căn khi inventory không xác nhận. Kết quả cần được ghi nhận sau khi chạy với Gemini và sample inventory đã ẩn danh; không coi phản hồi của model là bằng chứng thay thế cho kiểm thử thực tế.

## 5. Evaluate — quyết định hiện tại: NOT YET

| AI Readiness Checklist | Trạng thái | Bằng chứng cần bổ sung |
|---|---|---|
| Có sample inventory/logs sạch để test? | ☐ Chưa xác nhận | 200–500 listing đã ẩn danh, trường bắt buộc đầy đủ, snapshot trạng thái và 50–100 yêu cầu lịch sử đã gắn nhãn. |
| Rủi ro khi AI sai có kiểm soát? | ☑ Có thể kiểm soát trong pilot | Chỉ dùng shortlist nháp, hard filters bằng rule, tư vấn viên phê duyệt và có fallback thủ công. |
| Stakeholder sẵn sàng đổi quy trình? | ☐ Chưa xác nhận | Cần sales admin và quản lý vận hành đồng ý workflow, SLA xác minh và cách ghi feedback. |

**Quyết định: ☑ NOT YET — cần dữ liệu/baseline trước khi xây production.**

Nhóm nên triển khai một prototype offline, không dùng dữ liệu cá nhân thật, với inventory giả lập hoặc đã ẩn danh. Chỉ chuyển sang pilot có người dùng thật sau khi xác nhận quyền truy cập dữ liệu, đo baseline, đánh giá fairness, có cơ chế cập nhật listing và quy trình phê duyệt. Nếu các điều kiện này đạt, phạm vi GO tiếp theo là một dự án/tòa nhà, một nhóm tư vấn viên, và chỉ gợi ý shortlist chứ không tự động giao dịch.
