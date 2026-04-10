$oldBlock = @"
            <h4>Payment & Delivery</h4>
            <ul>
                <li><a href="#">TechOne Pay</a></li>
                <li><a href="#">Shop with Points</a></li>
                <li><a href="#">Reload Balance</a></li>
                <li><a href="#">Payment Methods</a></li>
            </ul>
"@

$newBlock = @"
            <h4>Payment & Delivery</h4>
            <ul>
                <li><a href="techone-pay.html">TechOne Pay</a></li>
                <li><a href="shop-with-points.html">Shop with Points</a></li>
                <li><a href="reload-balance.html">Reload Balance</a></li>
                <li><a href="payment-methods.html">Payment Methods</a></li>
            </ul>
"@

$files = Get-ChildItem -Filter *.html
foreach ($file in $files) {
    if ($file.Name -ne "scratch") {
        $content = Get-Content -Raw -Path $file.FullName
        $normalizedContent = $content -replace "`r`n", "`n"
        $normalizedOldBlock = $oldBlock -replace "`r`n", "`n"
        
        if ($normalizedContent.Contains($normalizedOldBlock)) {
            $newContent = $normalizedContent.Replace($normalizedOldBlock, $newBlock)
            Set-Content -Path $file.FullName -Value $newContent
        }
    }
}
