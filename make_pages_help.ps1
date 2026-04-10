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
    @{ file="shipping-rates.html"; title="Shipping Rates & Policies"; title_tag="Shipping Rates - TechOne"; desc="Find out exactly what it costs and how long it takes to ship to your destination." },
    @{ file="returns.html"; title="Returns & Replacements"; title_tag="Returns - TechOne"; desc="Not happy with your product? Learn about our 30-day hassle-free return policy." },
    @{ file="help-center.html"; title="TechOne Help Center"; title_tag="Help Center - TechOne"; desc="Find answers, resolve account issues, and get in touch with our live support team." }
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
