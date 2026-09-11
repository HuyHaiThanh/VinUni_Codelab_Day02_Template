# AI Interaction Log — Lab 02: AI Product Scoping

## 1. Mục tiêu sử dụng AI

Tôi sử dụng AI như một thought partner để chuyển các ý tưởng còn rộng về vận hành của Vin Smart Future thành các bài toán có thể đánh giá. Mục tiêu không phải là để AI quyết định thay tôi, mà là dùng AI để đặt câu hỏi, làm rõ actor, workflow, bottleneck, metric và ranh giới vận hành trước khi chọn bài toán để đi sâu.

## 2. AI đã hỗ trợ những gì

AI giúp tôi brainstorm các pain point theo bốn lenses: tác vụ lặp lại, tác vụ tốn thời gian, dịch vụ có thể nâng cấp bằng AI và pain point của stakeholder. Từ danh sách ban đầu, tôi chọn ba bài toán có dữ liệu đầu vào và điểm can thiệp tương đối rõ: tóm tắt hồ sơ hậu mãi VinFast, tiếp nhận nhu cầu đặt lịch tại Vinmec, và phân loại phản hồi tại Vinpearl/VinWonders.

AI cũng giúp cấu trúc Quick Problem Cards. Cụ thể, AI gợi ý cách mô tả workflow theo trình tự, chỉ ra bước cần human-in-the-loop và biến mục tiêu chung thành metric có thể đo, như thời gian xử lý trung bình, tỷ lệ phiếu đủ thông tin hoặc thời gian định tuyến phản hồi khẩn.

## 3. Điểm AI có thể sai hoặc thiếu căn cứ

AI có thể tạo ra mô tả nghe hợp lý về quy trình nội bộ, số lượng ticket, thời gian xử lý hoặc chính sách của các công ty, dù không có quyền truy cập vào dữ liệu vận hành thực tế. Vì vậy, các con số trong Quick Cards (ví dụ 10–15 phút/yêu cầu hay mục tiêu 85%) chỉ là giả định để thiết kế bài lab, không phải số liệu đã được Vingroup/VinFast/Vinmec/Vinpearl công bố hay xác nhận.

Đối với Vinmec, AI cũng không được phép tư vấn chẩn đoán, kê đơn, đánh giá mức độ bệnh hoặc tự xác nhận lịch khám. Nếu chỉ viết prompt chung chung như “hãy hỗ trợ khách hàng đặt khám”, model có thể trả lời vượt quá phạm vi hành chính và tạo ra rủi ro an toàn.

## 4. Cách tôi đã chỉnh prompt và ranh giới

Tôi thay prompt brainstorm rộng bằng các yêu cầu cụ thể: nêu actor, 3–5 bước của workflow hiện tại, bước nghẽn, dữ liệu đầu vào, metric và phương án fallback. Tôi yêu cầu AI gắn nhãn rõ đâu là “giả định cần kiểm chứng”, thay vì trình bày giả định như sự thật.

Với bài toán Vinmec, tôi đặt operational boundary rõ ràng: AI chỉ thu thập thông tin hành chính, trả lời từ knowledge base đã duyệt và tạo phiếu nháp. Mọi câu hỏi về triệu chứng, chẩn đoán, thuốc, cấp cứu hoặc quyết định lịch cuối cùng phải được chuyển cho nhân viên phù hợp. Với VinFast và Vinpearl/VinWonders, AI chỉ tạo tóm tắt/nháp và đề xuất phân loại; con người vẫn xác minh điều kiện bảo hành, duyệt phản hồi gửi khách hàng và xử lý case rủi ro.

## 5. Bài học rút ra

AI làm quá trình scoping nhanh hơn vì giúp tôi nhìn thấy các câu hỏi còn thiếu và nhiều phương án thiết kế. Tuy nhiên, giá trị của bài toán không đến từ câu trả lời trôi chảy của model mà đến từ việc xác minh workflow với người vận hành, đo baseline bằng dữ liệu thật và đặt ranh giới an toàn có thể kiểm tra. Trước khi đề xuất xây prototype, tôi cần phỏng vấn stakeholder, lấy mẫu dữ liệu đã được cấp quyền và xác nhận các metric với đội vận hành.
