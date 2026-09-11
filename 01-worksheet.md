# Lab 02 — Worksheet: AI Product Scoping (Vin Smart Future)

---

## 🏛️ 1. Bối cảnh thực tế: Vin Smart Future (Vingroup)

**Vingroup** — Tập đoàn tư nhân lớn nhất Việt Nam — vừa sáp nhập toàn bộ các phòng ban công nghệ thuộc các công ty thành viên thành một đơn vị công nghệ thống nhất mang tên **Vin Smart Future**. 

Nhiệm vụ của **Vin Smart Future** là xây dựng các giải pháp AI, số hóa, và tự động hóa cốt lõi để nâng cao hiệu suất vận hành và trải nghiệm khách hàng xuyên suốt các công ty thành viên:
* 🚗 **VinFast:** Hệ thống xe điện thông minh (EV), trợ lý AI ảo trong xe, dự đoán bảo trì pin, và quản lý chuỗi cung ứng sản xuất.
* 🚕 **Xanh SM (GSM):** Vận hành đội xe taxi/xe máy điện thông minh, điều vận thông minh (Smart Dispatching), tối ưu hóa lộ trình di chuyển.
* 🏢 **Vinhomes:** Quản lý đô thị thông minh (Smart Cities), trợ lý cư dân thông minh, tối ưu hóa mức tiêu thụ năng lượng.
* 🏥 **Vinmec:** Y tế thông minh, chẩn đoán hình ảnh bằng AI, tối ưu hóa quản lý hồ sơ bệnh án.
* 🎢 **Vinpearl / VinWonders:** Trải nghiệm du lịch số hóa, quản lý phòng và luồng khách thông minh tại các khu vui chơi.

Trong buổi Lab hôm nay, nhóm của bạn sẽ đóng vai trò là **AI Product Engineer** tại **Vin Smart Future**, tiến hành tìm kiếm, scoping, phân tích độ khả thi, thiết lập ranh giới vận hành, và xây dựng một **bản mẫu kỹ thuật (prompt prototype)** cho một bài toán cụ thể thuộc một trong những mảng kinh doanh trên.

---

## 📊 2. Cơ cấu tính điểm bài lab

### 👥 Điểm nhóm (60 điểm)

| Gate | Điểm | Deliverable | Tiêu chí chấm |
|---|---:|---|---|
| **G1. Workflow Mapping** | 20 | Problem Deep-Dive | Vẽ chi tiết quy trình hiện tại: các bước, handoff, thời gian, bottleneck |
| **G2. Problem Statement** | 20 | Problem Deep-Dive | Problem Statement 6-field bám sát thực tế, metric có số và ranh giới rõ ràng |
| **G3. AI Fit & Future Flow** | 10 | Problem Deep-Dive | So sánh Rule vs LLM vs Agent, future flow có bước AI, ranh giới và Fallback |
| **G4. Decision Quality** | 10 | Problem Deep-Dive | Quyết định Go/Not Yet/No-Go trung thực và có chứng cứ rõ ràng |

### 👤 Điểm cá nhân (40 điểm)

| Gate | Điểm | Deliverable | Tiêu chí chấm |
|---|---:|---|---|
| **I1. Scan & Cards** | 15 | Quick Cards | Liệt kê 5 problems sử dụng 3 lenses, hoàn thiện 3 quick cards chất lượng |
| **I2. Prototyping** | 10 | 02-lab/ | Chạy thử nghiệm programmatic prompt prototype thành công |
| **I3. AI Log & Reflection** | 15 | 03-ai-log.md | Phản ánh trung thực về việc dùng AI làm thought-partner (giúp gì, sai gì, sửa gì) |

---

# 🚀 Phase 0 — worked Example: Xanh SM Intelligent Dispatcher (15 min)

*Giảng viên walk-through ví dụ thực tế từ Vin Smart Future để bạn hiểu rõ cách scoping một bài toán AI.*
Đọc chi tiết worked example tại file [02-deliverable-example.md](02-deliverable-example.md).

---

# 🔍 Phase 1 — SCAN (Cá nhân, 20 min)

Hãy sử dụng **4 Lenses** dưới đây để quét qua hoạt động vận hành của các công ty thành viên Vingroup. Ghi lại **ít nhất 5 bài toán/bottleneck** thực tế.

### 4 Lenses tìm bài toán AI cho Vingroup:
1. **Lặp lại (Repetitive):** Tác vụ lặp đi lặp lại nhiều lần hằng ngày. (Ví dụ: So khớp hóa đơn sạc điện tại VinFast, route lại chuyến taxi tại Xanh SM).
2. **Tốn thời gian (Time-consuming):** Tác vụ ngốn thời gian xử lý thủ công của nhân viên. (Ví dụ: Soạn thảo phản hồi đánh giá 1-star của cư dân Vinhomes).
3. **AI có thể tốt hơn (AI-upgrade):** Dịch vụ khách hàng hiện tại còn chậm hoặc phản hồi rập khuôn. (Ví dụ: Chatbot CSKH Vinpearl hỗ trợ đặt vé vui chơi).
4. **Pain từ người khác (Stakeholder Pain):** Bottleneck khiến khách hàng hoặc nhân viên thực địa phàn nàn. (Ví dụ: Tài xế Xanh SM phàn nàn về việc hệ thống gợi ý điểm đón khách không chính xác).

> [!TIP]
> **🤖 AI Prompts — Partner brainstorm:**
> Hãy sử dụng prompt sau để brainstorm các bài toán thực tế nếu bạn chưa có ý tưởng:
> *"Tôi là AI Engineer tại Vin Smart Future (Vingroup). Tôi đang tìm kiếm các pain point vận hành cụ thể có thể tối ưu bằng AI cho mảng [Chọn một: VinFast / Xanh SM / Vinhomes / Vinmec]. Hãy gợi ý cho tôi 5 quy trình nghiệp vụ thủ công, tốn nhiều thời gian và gây rò rỉ hiệu suất kèm con số thống kê ước tính về tổn thất."*

### 📝 List bài toán của tôi:
| # | Subsidiary (VinFast/Xanh SM...) | Lens | Mô tả ngắn bài toán |
|---|----------------------------------|------|---------------------|
| 1 | VinFast | Lặp lại (Repetitive) | Nhân viên hậu mãi phải đọc, đối chiếu lịch sử sửa chữa, cảnh báo xe và chính sách bảo hành cho từng yêu cầu. Cần tự động trích xuất thông tin, phát hiện hồ sơ thiếu và tạo bản tóm tắt để cố vấn dịch vụ kiểm tra trước khi phản hồi khách hàng. |
| 2 | Xanh SM (GSM) | Pain từ người khác (Stakeholder Pain) | Tài xế và điều phối viên gặp tình huống điểm đón ghim sai, đường cấm hoặc thay đổi nhu cầu vào giờ cao điểm; việc xác minh thủ công qua cuộc gọi/chat làm chậm ghép cuốc và tăng tỷ lệ hủy. AI có thể nhận diện cuốc bất thường, gợi ý điểm đón thay thế và chuyển trường hợp rủi ro cho điều phối viên. |
| 3 | Vinhomes | Tốn thời gian (Time-consuming) | Ban quản lý nhận nhiều phản ánh tự do qua app, hotline và email về kỹ thuật, vệ sinh, an ninh. Nhân viên phải đọc, phân loại, tìm tòa/khu vực và chuyển ticket thủ công, dễ sai SLA; AI có thể tóm tắt, phân loại mức độ khẩn và định tuyến tới đúng đội vận hành để nhân viên duyệt. |
| 4 | Vinmec | AI có thể tốt hơn (AI-upgrade) | Tổng đài/nhân viên đặt lịch hiện trả lời lặp lại các câu hỏi về chuyên khoa, chuẩn bị trước khám và khung giờ trống, khiến khách chờ lâu ngoài giờ hành chính. Trợ lý hội thoại có thể giải đáp thông tin hành chính và thu thập nhu cầu đặt lịch, nhưng không chẩn đoán, kê đơn hoặc thay thế nhân viên y tế. |
| 5 | Vinpearl / VinWonders | Tốn thời gian (Time-consuming) | Nhân viên chăm sóc khách hàng phải tổng hợp phản hồi sau lưu trú/vui chơi từ nhiều kênh, dịch các đánh giá đa ngôn ngữ và soạn phản hồi theo từng vấn đề. AI có thể gom chủ đề, phát hiện phản hồi tiêu cực cần ưu tiên và soạn nháp phản hồi để quản lý phê duyệt trước khi gửi. |

---

# 🃏 Phase 2 — QUICK-ASSESS (Cá nhân, 30 min)

Chọn **top 3 bài toán** từ danh sách trên và hoàn thiện **3 Quick Problem Cards** dưới đây (10 phút/card).

### QUICK PROBLEM CARD #1 — VinFast: Tóm tắt và kiểm tra hồ sơ hậu mãi

| Trường | Nội dung |
|---|---|
| **Bài toán (1 câu)** | Giảm thời gian cố vấn dịch vụ VinFast đọc và đối chiếu hồ sơ bảo hành/sửa chữa trước khi phản hồi yêu cầu hậu mãi của khách hàng. |
| **Công ty thành viên** | ☑ VinFast |
| **Ai đang đau (Actor)?** | Cố vấn dịch vụ, nhân viên bảo hành và khách hàng chờ phản hồi về điều kiện bảo hành. |
| **Workflow thủ công hiện tại** | 1. Khách gửi yêu cầu qua app/hotline → 2. Cố vấn tìm số VIN và lịch sử sửa chữa trên nhiều hệ thống → 3. Đối chiếu chính sách, hóa đơn và mã lỗi → 4. Hỏi bổ sung nếu thiếu chứng từ → 5. Soạn phản hồi/trình quản lý duyệt. |
| **Bước tốn thời gian/lỗi nhất** | Bước 2–3: tìm và đối chiếu dữ liệu phân tán; ước tính 10–15 phút/yêu cầu, dễ bỏ sót hồ sơ hoặc áp sai điều khoản. |
| **AI hỗ trợ ở đâu?** | Sau khi nhân viên chọn hồ sơ khách hàng, AI trích xuất dữ kiện, tóm tắt lịch sử, liệt kê chứng từ còn thiếu và tạo nháp phản hồi kèm các điều khoản cần kiểm tra. Nhân viên xác nhận kết luận cuối. |
| **Success metric** | Giảm median handling time từ 12 xuống ≤6 phút/yêu cầu; ≥85% bản tóm tắt được cố vấn chấp nhận sau chỉnh sửa nhỏ; tỷ lệ phản hồi sai điều kiện bảo hành không tăng so với baseline. |
| **Quick Architecture** | ☑ LLM + truy xuất dữ liệu có quyền truy cập; rule-based kiểm tra điều kiện bắt buộc; human-in-the-loop phê duyệt. |

### QUICK PROBLEM CARD #4 — Vinmec: Trợ lý tiếp nhận nhu cầu đặt lịch

| Trường | Nội dung |
|---|---|
| **Bài toán (1 câu)** | Hỗ trợ tổng đài Vinmec trả lời câu hỏi hành chính và thu thập thông tin đặt lịch nhất quán, để giảm thời gian chờ trước khi nhân viên xác nhận lịch. |
| **Công ty thành viên** | ☑ Vinmec |
| **Ai đang đau (Actor)?** | Khách hàng cần đặt lịch, nhân viên tổng đài/điều phối lịch hẹn và lễ tân phòng khám. |
| **Workflow thủ công hiện tại** | 1. Khách gọi hoặc nhắn tin → 2. Nhân viên hỏi nhu cầu, chuyên khoa, cơ sở và thời gian → 3. Tra thông tin hành chính/khung giờ → 4. Nhập yêu cầu vào hệ thống → 5. Xác nhận lại hoặc chuyển bác sĩ khi có câu hỏi y khoa. |
| **Bước tốn thời gian/lỗi nhất** | Bước 2–4: hỏi lặp lại và nhập dữ liệu; 5–8 phút/yêu cầu, dễ thiếu thông tin liên hệ hoặc đặt nhầm cơ sở/chuyên khoa. |
| **AI hỗ trợ ở đâu?** | Chatbot/voice assistant hỏi theo biểu mẫu, giải đáp thông tin hành chính đã được phê duyệt, tóm tắt yêu cầu và tạo phiếu nháp cho nhân viên. Câu hỏi triệu chứng, chẩn đoán, thuốc hoặc tình huống khẩn cấp phải chuyển ngay tới nhân viên/y tế. |
| **Success metric** | ≥70% yêu cầu đủ thông tin ngay ở lần tiếp nhận đầu; giảm thời gian tạo phiếu từ 6 xuống ≤2 phút; 100% câu hỏi y khoa/khẩn cấp được chuyển tuyến, không có tư vấn chẩn đoán tự động. |
| **Quick Architecture** | ☑ LLM có guardrails + rule-based triage và knowledge base đã duyệt; human-in-the-loop xác nhận lịch và xử lý ngoại lệ. |

### QUICK PROBLEM CARD #5 — Vinpearl/VinWonders: Phân loại phản hồi sau trải nghiệm

| Trường | Nội dung |
|---|---|
| **Bài toán (1 câu)** | Tự động tổng hợp, phân loại và soạn nháp phản hồi cho đánh giá sau lưu trú/vui chơi để đội CSKH ưu tiên đúng các phản hồi tiêu cực. |
| **Công ty thành viên** | ☑ Khác: Vinpearl / VinWonders |
| **Ai đang đau (Actor)?** | Nhân viên CSKH, quản lý vận hành tại cơ sở và khách hàng gửi phản hồi qua OTA, app, email hoặc mạng xã hội. |
| **Workflow thủ công hiện tại** | 1. Nhân viên thu thập đánh giá từ nhiều kênh → 2. Dịch/đọc nội dung và nhận diện chủ đề → 3. Gắn nhãn mức độ, cơ sở và bộ phận phụ trách → 4. Chuyển ticket cho vận hành → 5. Soạn và duyệt phản hồi khách hàng. |
| **Bước tốn thời gian/lỗi nhất** | Bước 2–3: đọc đánh giá tự do, đa ngôn ngữ và phân loại thủ công; khoảng 3–5 phút/đánh giá, phản hồi nghiêm trọng có thể bị bỏ sót hoặc chuyển chậm. |
| **AI hỗ trợ ở đâu?** | AI dịch/tóm tắt, gán chủ đề (phòng, vệ sinh, dịch vụ, an toàn), chấm mức khẩn cấp và soạn nháp theo giọng điệu thương hiệu. Quy tắc ưu tiên các tín hiệu an toàn/khủng hoảng; quản lý duyệt toàn bộ phản hồi trước khi gửi. |
| **Success metric** | ≥90% đánh giá được phân loại trong <30 giây; ≥95% phản hồi có tín hiệu an toàn được chuyển đúng bộ phận trong 5 phút; giảm thời gian soạn nháp từ 4 xuống ≤1,5 phút/đánh giá. |
| **Quick Architecture** | ☑ LLM classification/drafting + rule-based routing/escalation; human-in-the-loop phê duyệt nội dung gửi ra ngoài. |

> [!TIP]
> **🤖 AI Prompts — Stress-Test thẻ bài toán:**
> Hãy dán nội dung thẻ bài toán của bạn vào LLM để nhận phản biện:
> *"Đây là một thẻ bài toán vận hành tôi đề xuất cho Vin Smart Future: [Dán nội dung]. Hãy đóng vai trò là một CFO và Trưởng phòng Vận hành cực kỳ khắt khe, chỉ ra cho tôi 3 điểm yếu về logic, metric, và giải thích vì sao rule-based code thông thường có thể giải quyết bài toán này tốt hơn là dùng AI."*

---

# 🏗️ Phase 3 — DEEP-DIVE (Nhóm, 85 min)

## 3.1. Current-State Workflow Mapping (25 min)
**Vẽ quy trình hiện tại lên bảng/giấy A3.** Sử dụng các ký hiệu:
* 🔴 **Bottleneck:** Bước gây tắc nghẽn, tốn thời gian, hoặc sai sót nhiều nhất.
* 🔄 **Handoff:** Điểm chuyển giao thông tin giữa người và hệ thống, hoặc giữa các bộ phận.
* Ghi rõ thời gian vận hành trung bình: **Tổng cộng = ____ phút/lượt**.

## 3.2. Problem Statement (6-field) & Metrics (15 min)
Điền đầy đủ 6 trường thông tin của bài toán:

| Field | Nội dung chi tiết |
|---|---|
| **1. Actor / Operator** | Ai đang thực hiện tác vụ hằng ngày? |
| **2. Current Workflow** | Mô tả tóm tắt quy trình thủ công hiện tại và công cụ sử dụng. |
| **3. Bottleneck** | Bước nào chậm, lỗi, hoặc cần xử lý ngôn ngữ tự động nhiều nhất? |
| **4. Business Impact** | Tổn thất thực tế đo bằng thời gian, chi phí, hoặc SLA của Vingroup. |
| **5. Success Metric** | AI giải quyết được thì đạt ngưỡng số mấy? (Ví dụ: *"85% vé được phân loại dưới 10s"*). |
| **6. Operational Boundary** | AI được phép làm gì, TUYỆT ĐỐI không được làm gì, điểm nào cần duyệt? |

## 3.3. Future-State Flow & AI Fit (25 min)
* **Xác định mức AI Fit (AI-Fit Matrix):** Giải pháp thuộc nhóm nào? [ ] Rule / State-Machine [ ] LLM Feature [ ] Agentic Loop.
* **Vẽ Future-State Flow:** Đánh dấu rõ:
  * 🔵 **AI Step:** Tác vụ LLM xử lý.
  * 🟢 **Human Step (HITL):** Bước con người phê duyệt/review (Human-in-the-loop).
  * ↩️ **Fallback:** Kế hoạch dự phòng khi LLM trả về kết quả lỗi hoặc không tự tin.

---

# 💻 Phase 4 — TECHNICAL PROMPT PROTOTYPE (Nhóm, 30 min)

Để đảm bảo kỹ sư của Vin Smart Future luôn giữ vững năng lực lập trình, nhóm của bạn sẽ tiến hành **lập trình bản mẫu prompt** trực tiếp trên **Gemini 2.5 Flash** bằng Python để stress-test hệ thống.

### Hướng dẫn thực hiện:
1. Mở file [starter-code/prompt_prototype.py](starter-code/prompt_prototype.py) bằng VS Code/Cursor.
2. Hoàn thiện các nội dung sau:
   * **System Prompt:** Viết chỉ thị cực kỳ nghiêm ngặt quy định vai trò, nhiệm vụ, định dạng output và **Operational Boundary (Ranh giới cấm)** của mô hình.
   * **Structured Output:** Định nghĩa định dạng JSON output rõ ràng.
   * **Adversarial Test Cases:** Viết ít nhất 3 prompts "tấn công" (Adversarial inputs) cố tình dụ AI vượt ranh giới hoặc đưa ra câu trả lời không được phép để kiểm tra xem ranh giới của bạn có thực sự vững chắc.
3. Chạy file python:
   ```bash
   python3 prompt_prototype.py
   ```
4. Kiểm tra xem các ranh giới an toàn có bị LLM phá vỡ hay không và ghi lại kết quả vào worksheet.

---

# 🏁 Phase 5 — EVALUATE (Nhóm, 20 min)

### AI Readiness Checklist:
1. [ ] Chúng tôi có sẵn dữ liệu mẫu/logs sạch để test?
2. [ ] Rủi ro khi AI sai có nằm trong tầm kiểm soát (qua HITL hoặc Fallback)?
3. [ ] Stakeholders sẵn sàng thay đổi quy trình làm việc cũ?

### Quyết định cuối cùng của Ban Giám Đốc Vin Smart Future:
[ ] **GO (Bắt đầu xây dựng Prototype):** Bắt đầu phát triển với scope hẹp.
[ ] **NOT YET (Cần tích lũy thêm dữ liệu/xác lập baseline):** Trì hoãn để chuẩn bị thêm.
[ ] **NO-GO (Không khả thi / Rule-based tốt hơn):** Hủy bỏ dự án AI này.

**Justification (Lý giải quyết định dựa trên bằng chứng kỹ thuật và chi phí):**
> *Viết lý giải chi tiết tại đây*

---

# 📝 Phase 6 — REFLECTION (Cá nhân)
*Ghi nhận phản ánh của cá nhân bạn về việc phối hợp với AI trong buổi học hôm nay vào file `03-ai-log.md`.*
