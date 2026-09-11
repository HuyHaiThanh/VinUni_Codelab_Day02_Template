Add-Type -AssemblyName System.Drawing

$width = 1800
$height = 1250
$bitmap = [System.Drawing.Bitmap]::new($width, $height)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.Clear([System.Drawing.Color]::White)

$titleFont = [System.Drawing.Font]::new('Segoe UI', 28, [System.Drawing.FontStyle]::Bold)
$sectionFont = [System.Drawing.Font]::new('Segoe UI', 18, [System.Drawing.FontStyle]::Bold)
$bodyFont = [System.Drawing.Font]::new('Segoe UI', 14)
$smallFont = [System.Drawing.Font]::new('Segoe UI', 12)
$dark = [System.Drawing.Color]::FromArgb(31, 41, 55)
$blue = [System.Drawing.Color]::FromArgb(219, 234, 254)
$red = [System.Drawing.Color]::FromArgb(254, 226, 226)
$green = [System.Drawing.Color]::FromArgb(220, 252, 231)
$gray = [System.Drawing.Color]::FromArgb(243, 244, 246)

function Draw-Box([int]$x, [int]$y, [int]$w, [int]$h, $fill, [string]$heading, [string]$body) {
    $brush = [System.Drawing.SolidBrush]::new($fill)
    $pen = [System.Drawing.Pen]::new($dark, 2)
    $graphics.FillRectangle($brush, $x, $y, $w, $h)
    $graphics.DrawRectangle($pen, $x, $y, $w, $h)
    $graphics.DrawString($heading, $sectionFont, [System.Drawing.SolidBrush]::new($dark), $x + 14, $y + 12)
    $rect = [System.Drawing.RectangleF]::new($x + 14, $y + 52, $w - 28, $h - 64)
    $format = [System.Drawing.StringFormat]::new()
    $format.Trimming = [System.Drawing.StringTrimming]::EllipsisWord
    $graphics.DrawString($body, $bodyFont, [System.Drawing.SolidBrush]::new($dark), $rect, $format)
    $pen.Dispose(); $brush.Dispose(); $format.Dispose()
}

function Draw-Arrow([int]$x1, [int]$y1, [int]$x2, [int]$y2) {
    $pen = [System.Drawing.Pen]::new($dark, 3)
    $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::ArrowAnchor
    $graphics.DrawLine($pen, $x1, $y1, $x2, $y2)
    $pen.Dispose()
}

$graphics.DrawString('Vinhomes Rental Match Assistant - Current-State Workflow', $titleFont, [System.Drawing.SolidBrush]::new($dark), 55, 35)
$graphics.DrawString('Scope: create a verified draft shortlist; no booking, price promise, or automatic customer message.', $bodyFont, [System.Drawing.SolidBrush]::new($dark), 58, 90)

Draw-Box 70 190 285 220 $blue '1. Receive need' 'Customer sends budget, bedrooms, furnishings, location and move-in date by chat or phone. 2-3 min.'
Draw-Box 420 190 285 220 $red '2. Clarify criteria' 'Consultant asks follow-up questions. BOTTLENECK: missing budget or move-in date causes repeated messages. 4-7 min.'
Draw-Box 770 190 285 220 $red '3. Search listings' 'Consultant opens multiple sheets/groups and filters manually. BOTTLENECK: price and availability may be outdated. 6-10 min.'
Draw-Box 1120 190 285 220 $gray '4. Verify listing' 'HANDOFF: confirm actual price, availability and viewing slot with owner or building manager. Variable wait.'
Draw-Box 1470 190 260 220 $red '5. Compare & reply' 'Prepare shortlist and explain trade-offs. BOTTLENECK: inconsistent comparison. 4-6 min.'

Draw-Arrow 355 300 420 300
Draw-Arrow 705 300 770 300
Draw-Arrow 1055 300 1120 300
Draw-Arrow 1405 300 1470 300

$graphics.DrawString('Total active handling time: approximately 15-25 minutes per request (assumption to validate with logs).', $sectionFont, [System.Drawing.SolidBrush]::new($dark), 70, 420)
$graphics.DrawString('Legend: red = bottleneck; gray = handoff; blue = customer/consultant intake.', $smallFont, [System.Drawing.SolidBrush]::new($dark), 70, 460)

$graphics.DrawString('Future-State Guardrails', $titleFont, [System.Drawing.SolidBrush]::new($dark), 55, 560)
Draw-Box 120 680 310 190 $blue 'AI extracts needs' 'Convert free text into structured criteria and ask only for missing fields.'
Draw-Box 500 680 310 190 $blue 'Rules filter inventory' 'Hard filters: budget, bedrooms, move-in date, status and data-access permission.'
Draw-Box 880 680 310 190 $blue 'AI drafts shortlist' 'Compare only approved records. Include listing IDs, trade-offs and verification-required fields.'
Draw-Box 1260 680 310 190 $green 'Human approval' 'Consultant verifies price/availability/fairness, then chooses whether to send a customer-facing message.'
Draw-Arrow 430 775 500 775
Draw-Arrow 810 775 880 775
Draw-Arrow 1190 775 1260 775

$graphics.DrawString('Fallback: if inventory is stale, no listing matches, or confidence is low, stop and route to manual search.', $sectionFont, [System.Drawing.SolidBrush]::new($dark), 120, 940)
$graphics.DrawString('Operational boundary: AI never invents listings, books viewings, reserves units, promises prices, or ranks by sensitive attributes.', $bodyFont, [System.Drawing.SolidBrush]::new($dark), 120, 990)

$output = Join-Path $PSScriptRoot '..\04-workflow-diagram.png'
$bitmap.Save($output, [System.Drawing.Imaging.ImageFormat]::Png)
$graphics.Dispose(); $bitmap.Dispose()
