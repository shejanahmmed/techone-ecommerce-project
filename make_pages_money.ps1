$index = Get-Content index.html -Raw

$header = ""
if ($index -match '(?s)(<!DOCTYPE html>.*?</header>)') {
    $header = $matches[1]
}

$footer = ""
if ($index -match '(?s)(<!-- ===== FOOTER ===== -->.*</html>)') {
    $footer = $matches[1]
}

$pages = @(
    @{ file="sell.html"; title="Sell on TechOne"; title_tag="Sell on TechOne"; desc="Reach millions of customers. Register today and start growing your business." },
    @{ file="sell-apps.html"; title="Sell Your Apps"; title_tag="Sell Apps - TechOne"; desc="Distribute your apps globally on TechOne devices and our secure application marketplace." },
    @{ file="affiliate.html"; title="Become an Affiliate"; title_tag="Affiliate Program - TechOne"; desc="Earn commissions by promoting the products you love." },
    @{ file="advertise.html"; title="Advertise with Us"; title_tag="Advertise - TechOne"; desc="Showcase your brand directly to shoppers exactly when they are ready to buy." },
    @{ file="self-publish.html"; title="Self-Publish with TechOne"; title_tag="Self-Publish - TechOne"; desc="Publish your books, software, and media directly to eager customers worldwide." }
)

foreach ($page in $pages) {
    $pageHeader = $header -replace '<title>.*?</title>', "<title>$($page.title_tag)</title>"

    $main = @"

<main class="cart-main" style="flex-direction: column; min-height: 50vh; align-items: center; justify-content: center; text-align: center; padding: 60px 20px;">
    <div style="max-width: 800px; margin: 0 auto;">
        <h1 style="font-size: 2.5rem; color: var(--dark); margin-bottom: 20px;">$($page.title)</h1>
        <p style="font-size: 1.1rem; color: var(--text-muted); line-height: 1.6; margin-bottom: 40px;">
            $($page.desc)
        </p>
        <div style="background: #f8fafc; padding: 40px; border-radius: 8px; border: 1px dashed #cbd5e1;">
            <i class="fa-solid fa-person-digging" style="font-size: 3rem; color: var(--primary); margin-bottom: 15px;"></i>
            <h3 style="color: var(--dark-2);">Page Under Construction</h3>
            <p style="color: var(--text-muted); margin-top: 10px;">We are currently building this section. Please check back later!</p>
        </div>
        <a href="index.html" class="hero-btn-primary" style="margin-top: 30px; display: inline-block;">Return to Home</a>
    </div>
</main>

"@

    $fullContent = $pageHeader + $main + $footer
    Set-Content -Path $page.file -Value $fullContent
}
