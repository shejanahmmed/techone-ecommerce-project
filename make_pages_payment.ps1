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
    @{ file="techone-pay.html"; title="TechOne Pay"; title_tag="TechOne Pay"; desc="Welcome to a blazing fast, ultra-secure checkout experience made exclusively for you." },
    @{ file="shop-with-points.html"; title="Shop with Points"; title_tag="Shop with Points - TechOne"; desc="Redeem your reward points for instant discounts on thousands of eligible items." },
    @{ file="reload-balance.html"; title="Reload Balance"; title_tag="Reload Balance - TechOne"; desc="Add funds to your TechOne account balance to ensure instant purchases any time." },
    @{ file="payment-methods.html"; title="Payment Methods"; title_tag="Payment Methods - TechOne"; desc="Manage your saved credit cards, bank accounts, and mobile banking information." }
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
