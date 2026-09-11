# Tên nhóm: [Tự điền]
# Họ và tên: Nguyễn Văn Huy
# Email đăng ký: huyhaithanh51@gmail.com
"""Rebuild synthetic demo data and the current-state engineering diagram."""
import json
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]
rooms = []
for i in range(1, 31):
    rooms.append(dict(id=f'ROOM-{i:02}', label=f'Căn hộ giả lập {i:02}', project='Vinhomes - khu demo', distance_reference='Mốc tiện ích khu demo',
        rent_vnd=7_500_000 + (i % 8) * 750_000,
        fixed_fees_vnd=None if i % 7 == 0 else 600_000 + (i % 3) * 300_000,
        distance_km=round(1 + (i % 9) * .4, 1),
        available_from='2026-11-01' if i % 6 == 0 else '2026-09-15',
        updated_at='2026-08-20' if i % 5 == 0 else '2026-09-10',
        source=f'synthetic://ROOM-{i:02}', capacity=1 + i % 2,
        amenities=['window', 'private_bathroom'] if i % 2 else ['parking'],
        availability='unknown' if i % 11 == 0 else 'listed_available',
        usage_fees_note='Điện/nước theo sử dụng chưa được tính vào tổng cố định.'))
data = {'team': '[Tự điền]', 'name': 'Nguyễn Văn Huy', 'email': 'huyhaithanh51@gmail.com',
        'synthetic': True, 'as_of': '2026-09-11',
        'notice': 'Không phải tin cho thuê thật; khoảng cách và giá hoàn toàn giả lập.', 'rooms': rooms}
(ROOT / 'data/rooms.json').write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding='utf-8')

W, H = 1600, 1880
im = Image.new('RGB', (W,H), '#f8fafc')
d = ImageDraw.Draw(im)
regular = 'C:/Windows/Fonts/arial.ttf'
bold = 'C:/Windows/Fonts/arialbd.ttf'
def font(n, b=False): return ImageFont.truetype(bold if b else regular, n)
def text(x,y,t,n=27,color='#223047',b=False): d.text((x,y),t,font=font(n,b),fill=color)
text(80,40,'Tên nhóm: [Tự điền]  |  Họ và tên: Nguyễn Văn Huy',25)
text(80,78,'Email đăng ký: huyhaithanh51@gmail.com',25)
text(80,145,'QUY TRÌNH TÌM CHỖ Ở VINHOMES',46,b=True)
text(80,212,'Bối cảnh: cá nhân, cặp đôi và gia đình tìm thuê căn hộ Vinhomes',28)
text(80,260,'55 phút thao tác/phiên — số liệu giả định, chưa khảo sát',30,'#b45309',True)
steps = [
 ('01','Xác định nhu cầu','5 phút','Người tìm thuê / ghi chú',
  'Nhu cầu chỗ ở → ngân sách, vị trí, ngày vào ở',False),
 ('02','Thu thập tin căn hộ','15 phút','Người tìm thuê / nhóm đăng tin, website',
  'Tiêu chí → danh sách tin ứng viên; tin cũ hoặc trùng',True),
 ('03','Chuẩn hóa và hỏi thông tin thiếu','15 phút','Người tìm thuê ↔ chủ nhà/môi giới / tin nhắn',
  'Tin ứng viên → giá, phí và tình trạng cần xác minh',True),
 ('04','So sánh, lập danh sách ngắn','15 phút','Người tìm thuê / ghi chú hoặc bảng tính',
  'Tin đã tổng hợp → tối đa 3 căn hộ; kiểm tra điều kiện',True),
 ('05','Liên hệ xác minh, đề nghị lịch xem','5 phút','Người tìm thuê ↔ chủ nhà/môi giới / điện thoại',
  'Danh sách ngắn → yêu cầu xác minh và xem căn hộ',False),
]
for idx,(num,title,duration,actor,flow,bottleneck) in enumerate(steps):
    y = 345 + idx*235
    color = '#b91c1c' if bottleneck else '#1d4ed8'
    d.rounded_rectangle((80,y,1520,y+190),radius=14,fill='white',outline=color,width=3)
    d.rectangle((80,y+15,90,y+175),fill=color)
    text(110,y+20,f'{num}  {title}',32,b=True)
    text(1340,y+23,duration,27,color,True)
    text(110,y+78,actor,27)
    text(110,y+123,flow,27)
    if idx<4:
        d.line((800,y+193,800,y+226),fill='#64748b',width=4)
        d.polygon([(789,y+216),(811,y+216),(800,y+229)],fill='#64748b')
text(80,1560,'Đỏ: bottleneck ở bước 2–4 = 45 phút, mục tiêu giảm xuống ≤15 phút.',28,'#b91c1c',True)
text(80,1613,'↔ Handoff ở bước 3 và 5: người tìm thuê trao đổi với chủ nhà/môi giới.',28)
text(80,1670,'Chưa có phản hồi: giữ trạng thái thiếu dữ liệu và quay lại xác minh.',27)
text(80,1725,'Không tính thời gian chờ trả lời, di chuyển, xem căn hộ hoặc ký hợp đồng.',27)
text(80,1795,'Lab 02 • Current-State Workflow • Dữ liệu minh họa',24,'#64748b')
im.save(ROOT / '04-workflow-diagram.png')
print('Created 30 synthetic rooms and 04-workflow-diagram.png')
