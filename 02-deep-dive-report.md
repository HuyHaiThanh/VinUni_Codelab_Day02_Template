# 02 — Deep-Dive Report: Chatbot hỗ trợ người tìm thuê chỗ ở tại Vinhomes

> **Đề tài nhóm đã chốt:** Vinhomes — hỗ trợ người tìm thuê căn hộ để ở.
> **Nội dung:** Phase 3 (DEEP-DIVE) + Phase 5 (EVALUATE) của Lab 02.

> ⚠️ **Về tính xác thực của số liệu.** Quy trình và thời gian dưới đây là giả định cần khảo sát, chưa phải số liệu đo được. Các metric là mục tiêu thử nghiệm, chưa phải kết quả đạt được. Đây là đề xuất học tập, không khẳng định Vinhomes đang cung cấp dịch vụ này. Phạm vi không bao gồm mua bán bất động sản.

---

# 🏗️ Phase 3 — DEEP-DIVE

## 3.1. Current-State Workflow

Điểm khác biệt của bài toán này so với các đề tài vận hành nội bộ: **actor không phải nhân viên Vingroup mà là người đi thuê nhà.** Quy trình dưới đây là quy trình của chính họ, tự làm, không ai trả lương cho thời gian đó.

```text
┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│ Bước 1       │  │ Bước 2       │  │ Bước 3       │  │ Bước 4       │  │ Bước 5       │
│ Xác định     │  │ Tìm tin trên │  │ Nhắn hỏi giá,│  │ So sánh các  │  │ Hẹn và đi    │
│ ngân sách và │─>│ nhiều nguồn  │─>│ phí, nội thất│─>│ tin, chọn    │─>│ xem căn hộ   │
│ nhu cầu ở    │  │ rời rạc      │  │ tình trạng   │  │ danh sách    │  │ thực tế      │
│              │  │              │  │ bàn giao     │  │ ngắn         │  │              │
│ Ai: Người    │  │ Ai: Người    │  │ Ai: Người    │  │ Ai: Người    │  │ Ai: Người    │
│     thuê     │  │     thuê     │  │     thuê     │  │     thuê     │  │     thuê     │
│ ⏱ 5 phút     │  │ ⏱ 15 phút 🔴 │  │ ⏱ 12 phút 🔴 │  │ ⏱ 18 phút 🔴 │  │ ⏱ 5 phút     │
│ Cụ: Tự nghĩ  │  │ Cụ: Nhiều    │  │ Cụ: Chat,    │  │ Cụ: Ghi chú, │  │ Cụ: Lịch hẹn │
│              │  │     app/nhóm │  │     điện thoại│ │     Excel tay│  │              │
└──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘
                                            │                  │
                          🔄 Handoff: người thuê ──> chủ nhà / môi giới
                          (thời gian chờ phản hồi: vài giờ tới vài ngày,
                           nằm ngoài tầm kiểm soát của người thuê)
                                            │                  │
                                            ▼                  ▼
                              ┌──────────────────────────────────────┐
                              │ ↩️ Rework loop (giả định ~30% số tin) │
                              │ Tin đã cho thuê xong, giá thật khác   │
                              │ tin đăng, hoặc thiếu phí quản lý.     │
                              │ Người thuê quay lại Bước 2 tìm tiếp.  │
                              └──────────────────────────────────────┘

🔴 Bottleneck   🔄 Handoff   ↩️ Vòng lặp làm lại
⏱ Tổng một phiên tìm kiếm: 55 phút, trong đó Bước 2 đến 4 chiếm 45 phút (82%).
⏱ Chưa tính thời gian chờ chủ nhà hoặc môi giới phản hồi và thời gian đi xem.
```

**Ba điểm đau chính:**

**Thông tin nằm rải rác và không cùng định dạng.** Mỗi tin đăng mô tả một kiểu. Có tin ghi giá đã gồm phí quản lý, có tin không. Người thuê phải tự quy về cùng một mặt bằng mới so sánh được, và đây chính là phần tốn 18 phút ở bước 4.

**Điểm chuyển giao sang chủ nhà tạo độ trễ không kiểm soát được.** Người thuê hỏi xong phải chờ. Trong lúc chờ, căn hộ có thể đã có người khác thuê. Đây là loại chờ mà không công cụ nào xóa được, chỉ có thể giảm số lần phải chờ bằng cách hỏi đúng căn ngay từ đầu.

**Vòng lặp làm lại đến từ chất lượng dữ liệu, không đến từ người thuê.** Tin hết hiệu lực hoặc thiếu phí khiến công sức ở bước 3 và 4 bị bỏ đi. Giả định khoảng 30% số tin rơi vào trường hợp này, con số cần khảo sát để xác nhận.

---

## 3.2. Problem Statement (6-field)

| Field | Nội dung |
|---|---|
| **1. Actor / Operator** | Người đang tìm thuê căn hộ để ở tại một khu đô thị Vinhomes. Gồm cá nhân đi làm, cặp đôi, hoặc gia đình nhỏ. Không phải nhà đầu tư, không phải môi giới. |
| **2. Current Workflow** | Người thuê tự xác định ngân sách và nhu cầu, tìm tin trên nhiều nguồn rời rạc, nhắn hỏi từng chủ nhà hoặc môi giới về giá thật, phí quản lý, nội thất và ngày bàn giao, tự ghi chú so sánh, rồi chọn danh sách ngắn để đi xem. Năm bước, hoàn toàn thủ công, khoảng 55 phút cho một phiên tìm kiếm, chưa tính thời gian chờ phản hồi. |
| **3. Bottleneck** | Bước 2 đến 4, chiếm 45 trên 55 phút. Nguyên nhân là thông tin không cùng định dạng giữa các tin đăng, nhiều tin thiếu phí bắt buộc nên không so sánh được theo tổng chi phí thật, và người thuê không có cách biết tin nào còn hiệu lực trước khi nhắn hỏi. |
| **4. Business Impact** | Về phía người thuê: khoảng 45 phút mỗi phiên tìm kiếm bị tiêu vào việc đọc và quy đổi thông tin, cộng với rủi ro chọn nhầm căn vượt ngân sách thật vì phí bị bỏ sót. Về phía Vinhomes: người thuê tiềm năng phân tán sang các nguồn tin ngoài, và trải nghiệm tìm nhà rời rạc làm giảm khả năng giữ chân cư dân thuê. **Lưu ý:** đây là tác động định tính, nhóm chưa đo được quy mô bằng số liệu thật. |
| **5. Success Metric** | 1. Giảm thời gian lập danh sách ngắn từ 45 phút xuống dưới 15 phút mỗi phiên.<br>2. Trong các tình huống thực sự có căn phù hợp, ít nhất 90% trả về được một căn đúng trong top 3.<br>3. 100% căn được gắn nhãn "đáp ứng" phải thỏa mọi điều kiện bắt buộc, đo trên bộ thử có đáp án chuẩn.<br>Cả ba là mục tiêu thử nghiệm, chưa có baseline đo thật để đối chiếu. |
| **6. Operational Boundary** | **Được phép:** hỏi lại để làm rõ nhu cầu, chuyển nhu cầu thành tiêu chí lọc, giải thích tối đa 3 căn phù hợp từ dữ liệu có sẵn, nêu rõ thông tin nào còn thiếu.<br>**Cấm tuyệt đối:** bịa căn hộ, giá, khoảng cách hay tiện ích không có trong dữ liệu; khẳng định một tin còn hiệu lực khi chưa xác minh; tự nới ngân sách hoặc điều kiện bắt buộc của người dùng; gọi một mức giá chưa gồm đủ phí là trọn gói; khẳng định căn hộ an toàn hoặc chủ nhà uy tín chỉ dựa trên nội dung tin; tự đặt cọc, tự giữ căn, hoặc tự liên hệ chủ nhà và môi giới.<br>**Bắt buộc người quyết định:** chatbot chỉ thu hẹp lựa chọn. Việc xác minh và liên hệ do người dùng tự làm. |

---

## 3.3. Future-State Flow & AI Fit

### Chọn mức AI Fit

| Phương án | Đánh giá |
|---|---|
| Rule / Bộ lọc thông thường | Đủ cho phần lọc cứng, không đủ cho phần hiểu nhu cầu. Người thuê nói "ở một mình, gần chỗ làm, vào đầu tháng sau, ưu tiên có cửa sổ", một bộ lọc dạng ô tick không nhận được câu đó, và cũng không phân biệt được đâu là điều kiện bắt buộc đâu là ưu tiên linh hoạt. |
| **LLM Feature + bộ lọc theo quy tắc** ✅ | **Phù hợp nhất.** LLM lo phần hiểu ngôn ngữ tự nhiên, hỏi lại thông tin thiếu và giải thích vì sao một căn phù hợp. Code lo phần lọc ngân sách, vị trí, ngày vào ở và các điều kiện bắt buộc. Chia việc như vậy khiến LLM không có cơ hội bịa ra căn hộ không tồn tại. |
| Agentic Loop | Thừa và nguy hiểm. Một agent tự quyết sẽ có xu hướng tự nhắn cho chủ nhà hoặc tự nới tiêu chí khi không tìm được kết quả, đúng hai thứ nằm trong danh sách cấm. |

**Kết luận:** chọn **LLM Feature cộng bộ lọc theo quy tắc**. Nguyên tắc phân vai là mọi con số ràng buộc do code quyết, mọi câu chữ do LLM viết.

### Quy trình tương lai

```text
┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│ Bước 1       │  │ Bước 2       │  │ Bước 3       │  │ Bước 4       │
│ 🔵 Hội thoại │  │ Bộ lọc theo  │  │ 🔵 LLM giải  │  │ 🟢 Người dùng│
│ làm rõ nhu   │─>│ quy tắc: giá,│─>│ thích top 3  │─>│ đọc, tự xác  │
│ cầu, phân    │  │ vị trí, ngày │  │ kèm phí, mã  │  │ minh và tự   │
│ biệt bắt     │  │ vào ở, điều  │  │ căn, nguồn   │  │ liên hệ chủ  │
│ buộc vs ưu   │  │ kiện bắt     │  │ tin, thông   │  │ nhà          │
│ tiên         │  │ buộc (code)  │  │ tin còn thiếu│  │              │
│ ⏱ 3 phút     │  │ ⏱ tức thì    │  │ ⏱ ~10 giây   │  │ ⏱ 10 phút    │
└──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘
        │                 │                 │
        │                 │                 │
        ▼                 ▼                 ▼
┌───────────────┐ ┌───────────────┐ ┌───────────────┐
│ ↩️ Fallback A  │ │ ↩️ Fallback B  │ │ ↩️ Fallback C  │
│ Thiếu thông   │ │ Không có căn  │ │ Tin thiếu phí │
│ tin bắt buộc  │ │ nào thỏa hết  │ │ bắt buộc      │
│ (ngày vào ở)  │ │ điều kiện     │ │               │
│ ──> Hỏi lại,  │ │ ──> Báo rõ    │ │ ──> Gắn nhãn  │
│ không đoán    │ │ "không có kết │ │ "chưa đủ dữ   │
│               │ │ quả", hỏi     │ │ liệu xác nhận │
│               │ │ người dùng    │ │ ngân sách",   │
│               │ │ muốn nới tiêu │ │ không tính là │
│               │ │ chí nào. Tuyệt│ │ "đáp ứng"     │
│               │ │ đối không tự  │ │               │
│               │ │ nới.          │ │               │
└───────────────┘ └───────────────┘ └───────────────┘

🔵 AI Step   🟢 Human decision   ↩️ Fallback
⏱ Tổng dự kiến một phiên: khoảng 13 phút, so với 55 phút hiện tại.
```

### Cơ chế an toàn

**Người dùng là người quyết định cuối, không có ngoại lệ.** Chatbot dừng lại ở việc đưa ra danh sách ngắn kèm lý do. Mọi hành vi có hệ quả thật như liên hệ, đặt cọc, giữ căn đều nằm ngoài phạm vi.

**Chặn bịa đặt bằng kiến trúc, không bằng lời dặn.** LLM chỉ được chọn trong tập căn hộ mà bộ lọc trả về, mỗi căn kèm mã định danh. Câu trả lời nào nhắc tới mã không có trong tập đó sẽ bị loại bỏ bằng code trước khi hiển thị. Đây là lý do chính nhóm không chọn kiến trúc agent.

**Minh bạch thông tin thiếu thay vì che giấu.** Một căn thiếu phí quản lý vẫn được hiển thị, nhưng gắn nhãn "chưa đủ dữ liệu xác nhận ngân sách" và không được tính vào nhóm đáp ứng. Chi phí điện nước theo sử dụng luôn tách riêng khỏi tổng phí cố định.

**Không nới tiêu chí thay người dùng.** Khi không có kết quả, cám dỗ lớn nhất là trả về căn gần đúng để hội thoại không bị cụt. Đây là hành vi bị cấm, vì nó biến ngân sách của người dùng thành thứ có thể thương lượng mà họ không hay biết.

---

# 🏁 Phase 5 — EVALUATE

## AI Readiness Checklist

| # | Câu hỏi | Trả lời |
|---|---|---|
| 1 | Có sẵn dữ liệu mẫu sạch để test? | **Chưa.** Nhóm chưa xác minh được nguồn dữ liệu tin đăng nào có thể dùng hợp lệ. Prototype hiện dựa trên khoảng 30 tin giả lập. Đây là điểm yếu lớn nhất, vì chất lượng sản phẩm phụ thuộc gần như hoàn toàn vào độ tin cậy và độ mới của dữ liệu căn hộ. |
| 2 | Rủi ro khi AI sai có nằm trong tầm kiểm soát? | **Có.** Hậu quả nặng nhất là người dùng mất công liên hệ một căn không phù hợp, tức quay về đúng trải nghiệm hiện tại chứ không tệ hơn. Các ranh giới cấm tự liên hệ và cấm tự đặt cọc chặn mọi hệ quả tài chính. |
| 3 | Stakeholders sẵn sàng đổi quy trình? | **Chưa rõ.** Nhóm chưa phỏng vấn người đang tìm thuê tại Vinhomes, nên chưa biết 45 phút mỗi phiên có thực sự là nỗi đau đủ lớn hay không, cũng chưa biết họ có sẵn sàng tin vào gợi ý của một chatbot khi số tiền thuê là khoản chi lớn hằng tháng. |

## Quyết định

**[x] NOT YET — Cần xác minh dữ liệu và đo baseline trước khi xây prototype đầy đủ.**

### Justification

Nhóm chọn NOT YET dù giải pháp kỹ thuật đã rõ ràng, vì hai trong ba câu checklist chưa có câu trả lời khẳng định.

**Không có dữ liệu thật thì không có sản phẩm.** Toàn bộ giá trị của chatbot này nằm ở việc nó đọc được dữ liệu căn hộ đáng tin và còn hiệu lực. Nếu dữ liệu sai hoặc cũ, một chatbot chạy hoàn hảo vẫn cho ra kết quả vô dụng, thậm chí tệ hơn tự tìm vì người dùng tin nhầm. Hiện nhóm mới có tin giả lập, chưa xác minh được nguồn nào dùng được.

**Con số 45 phút chưa được đo.** Đây là ước lượng của chính nhóm, không phải kết quả khảo sát. Nếu người thuê thực tế chỉ mất 15 phút vì họ đã quen dùng vài nhóm quen thuộc, thì mục tiêu giảm xuống 15 phút không còn ý nghĩa và dự án mất lý do tồn tại.

**Lợi ích của LLM cần được chứng minh, chưa được giả định.** Nếu phần lớn người dùng chỉ lọc theo giá và vị trí, một bộ lọc thông thường đã đủ và rẻ hơn nhiều. Phần chatbot thắng là khi nhu cầu diễn đạt tự nhiên, có điều kiện mềm, và cần hỏi lại thông tin thiếu. Tỉ lệ người dùng thực sự cần điều đó là con số nhóm chưa có.

**Vì sao không chọn NO-GO.** Bài toán có thật, ranh giới an toàn rõ ràng, và rủi ro thấp. Không có gì cho thấy hướng này bất khả thi, chỉ là chưa đủ căn cứ để cam kết nguồn lực.

### Ba việc phải làm để chuyển sang GO

| # | Việc | Tiêu chí vượt qua |
|---|---|---|
| 1 | Phỏng vấn 8 tới 10 người đang tìm thuê tại Vinhomes về cách họ tìm và so sánh tin | Đo được thời gian thật một phiên tìm kiếm, xác nhận hoặc bác bỏ con số 45 phút |
| 2 | Xác minh nguồn dữ liệu tin đăng có thể dùng hợp lệ, gồm cả tần suất cập nhật | Có ít nhất một nguồn được phép dùng, tỉ lệ tin hết hiệu lực dưới ngưỡng chấp nhận được |
| 3 | Chạy thử trên 20 tình huống có đáp án chuẩn, so với bộ lọc thông thường trên cùng dữ liệu | Đạt trên 90% tình huống có căn phù hợp trả đúng trong top 3, và thắng rõ bộ lọc thường ở nhóm nhu cầu diễn đạt tự nhiên |

Bộ thử 20 tình huống gồm 12 trường hợp có căn đáp ứng, 4 trường hợp không có kết quả, và 4 trường hợp dữ liệu thiếu hoặc mâu thuẫn. Nhóm kiểm tra riêng bốn hành vi: hỏi lại khi thiếu thông tin, xử lý tin cũ, xử lý tin thiếu phí, và phản ứng khi yêu cầu vượt ngân sách. Khi so thời gian với bộ lọc thông thường, thời gian thu thập tin không được tính vào riêng một phương án.
