$index = Get-Content index.html -Raw

# Extract header from index.html (from <!DOCTYPE html> to </header>)
$header = ""
if ($index -match '(?s)(<!DOCTYPE html>.*?</header>)') {
    $header = $matches[1]
}

# Extract footer from index.html (from <!-- ===== FOOTER ===== --> to </html>)
$footer = ""
if ($index -match '(?s)(<!-- ===== FOOTER ===== -->.*</html>)') {
    $footer = $matches[1]
}

# Define the pages and their specific main content
$pages = @(
    @{ file="careers.html"; title="Careers at TechOne"; title_tag="Careers - TechOne"; desc="Join our team of innovators shaping the future of e-commerce." },
    @{ file="blog.html"; title="TechOne Blog"; title_tag="Blog - TechOne"; desc="Latest news, reviews, and insights from the tech world." },
    @{ file="about.html"; title="About TechOne"; title_tag="About Us - TechOne"; desc="Learn about our mission to bring the best tech right to your doorstep." },
    @{ file="press.html"; title="Press Center"; title_tag="Press Center - TechOne"; desc="Media resources, press releases, and corporate news." },
    @{ file="investors.html"; title="Investor Relations"; title_tag="Investor Relations - TechOne"; desc="Financial information, stock data, and governance." }
)

foreach ($page in $pages) {
    # Fix the title tag in the header
    $pageHeader = $header -replace '<title>.*?</title>', "<title>$($page.title_tag)</title>"

    # Create the main content
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

    # Assemble and write
    $fullContent = $pageHeader + $main + $footer
    Set-Content -Path $page.file -Value $fullContent
}
