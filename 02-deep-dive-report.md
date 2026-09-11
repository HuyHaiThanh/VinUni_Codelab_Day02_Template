# Phase 3 — DEEP-DIVE: Xanh SM - Xác nhận điểm đón tại địa điểm phức tạp

**Tên Nhóm:** Group 1
**Họ tên thành viên:** Đinh Trường An
**Email:** truongan1203.hp@gmail.com

---

## 3.1. Current-State Workflow
Quy trình hiện tại khi khách hàng ghim điểm đón ở ngõ sâu hoặc khu vực ô tô khó tiếp cận:

```text
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│ Bước 1       │     │ Bước 2       │     │ Bước 3       │     │ Bước 4       │
│ Khách đặt xe │     │ Bản đồ route │     │ Gọi/Chat xác │     │ Đổi điểm đón │
│ (ghim điểm   │ ──→ │ dẫn xe vào   │ ──→ │ minh thủ công│ ──→ │ hoặc hủy     │
│ ngõ sâu)     │     │ ngõ hẹp      │     │ qua lại      │     │ chuyến       │
│ Ai: Khách    │     │ Ai: Hệ thống │     │ Ai: TX & Khách│     │ Ai: TX/Khách │
│ ⏱ 1 phút     │     │ ⏱ 2 phút 🔴  │     │ ⏱ 5-10p 🔴   │     │ ⏱ 1 phút     │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘
🔴 = Bottlenecks (Ngẽn cổ chai)
⏱ Tổng thời gian: 8 - 13 phút / lượt. Rủi ro cao dẫn đến hủy chuyến và trải nghiệm xấu.
```

*(Chi tiết sơ đồ trực quan xem tại file `04-workflow-diagram.svg` đã nộp)*

---

## 3.2. Problem Statement (6-field)

| Field | Nội dung |
|---|---|
| **1. Actor / Operator** | Tài xế Xanh SM và Khách hàng; Điều phối viên/CSKH (khi cần hỗ trợ). |
| **2. Current Workflow** | Khách ghim điểm đón → Bản đồ định tuyến xe vào → Xe không thể tiếp cận/quay đầu → Tài xế gọi điện/chat mô tả mốc địa điểm → Khách đi bộ tìm xe hoặc một trong hai bên hủy chuyến. |
| **3. Bottleneck** | **Bước 2 & 3** (Hệ thống route hợp lệ nhưng thực tế ô tô khó vào, dẫn đến gọi/chat mất 5-10 phút). Hai bên dễ hiểu nhầm mốc địa điểm hoặc mất kiên nhẫn. |
| **4. Business Impact** | Tỷ lệ hủy chuyến cao ở các khu vực đông dân cư/ngõ hẹp; lãng phí thời gian di chuyển rỗng của tài xế (mất doanh thu); khách hàng bức xúc vì phải chờ đợi lâu và đi bộ xa. |
| **5. Success Metric** | 1. Giảm thời gian xác nhận điểm đón từ 7 phút xuống dưới 2 phút.<br>2. Giảm 20% tỷ lệ hủy chuyến do không tìm thấy điểm đón/không tiếp cận được.<br>3. Tỷ lệ điểm đón gợi ý được cả hai bên xác nhận đạt trên 85%. |
| **6. Operational Boundary** | AI chỉ được tạo bản nháp gợi ý "điểm đón an toàn" (đầu ngõ, điểm quay đầu). **Cấm:** AI không được tự động đổi điểm đón hoặc gửi tin nhắn khi chưa có sự xác nhận (approve) của khách và tài xế. Nếu map data không đủ tin cậy, fallback về quy trình gọi điện truyền thống. |

---

## 3.3. Future-State Flow & AI Fit

* **AI Fit:** Chọn **Rule-based + LLM Feature**. 
  - *Rule-based*: Dùng Map layer để đánh giá độ rộng đường, hướng cấm, lịch sử xe từng tiếp cận.
  - *LLM Feature*: Đọc hiểu chat/ghi âm ngắn giữa tài xế và khách để trích xuất mốc địa điểm, từ đó soạn nháp tin nhắn gợi ý điểm đón hợp lý.
* **Quy trình tương lai (Future-State):**

```text
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│ Bước 1       │     │ Bước 2       │     │ Bước 3       │     │ Bước 4       │
│ Khách ghim   │     │ 🔵 Hệ thống  │     │ 🔵 AI đọc    │     │ 🟢 TX & Khách│
│ điểm đón khó │ ──→ │ cảnh báo ngõ │ ──→ │ chat & nháp  │ ──→ │ cùng bấm     │
│ tiếp cận     │     │ hẹp (Rule)   │     │ điểm đón mới │     │ xác nhận     │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘
                                                                      │
                                                                      ▼
                                                               ↩️ Fallback:
                                                               Nếu AI gợi ý sai,
                                                               khách/tài xế tự
                                                               gọi điện như cũ.
```

---

## Phase 5 — EVALUATE & GO / NO-GO DECISION

Dựa trên AI Readiness Checklist, nhóm quyết định: **GO (TIẾN HÀNH)**

**Lý do:**
1. **Dữ liệu sẵn sàng:** Dữ liệu bản đồ (độ rộng đường) và lịch sử GPS xe Xanh SM hoàn toàn có sẵn trong hệ sinh thái VinFast/Xanh SM. Dữ liệu chat log cũng dễ dàng trích xuất từ app.
2. **Khả thi kỹ thuật:** LLM xử lý hội thoại ngắn gọn để trích xuất thực thể (Mốc địa điểm, số nhà) là tác vụ cực kỳ phù hợp và độ chính xác cao. Sự kết hợp Rule-based (Map data) làm tăng tính chính xác tuyệt đối của định vị.
3. **An toàn / Rủi ro thấp:** Thiết kế bắt buộc có sự đồng thuận (HITL - Human in the loop) từ cả tài xế và khách hàng giúp loại bỏ hoàn toàn rủi ro AI tự ý đổi điểm đón sai, đảm bảo an toàn tuyệt đối cho vận hành.
