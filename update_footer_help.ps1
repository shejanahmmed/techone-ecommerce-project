$oldBlock = @"
            <h4>Let Us Help You</h4>
            <ul>
                <li><a href="#">Your Account</a></li>
                <li><a href="#">Your Orders</a></li>
                <li><a href="#">Shipping Rates</a></li>
                <li><a href="#">Returns & Replacements</a></li>
                <li><a href="#">Help Center</a></li>
            </ul>
"@

$newBlock = @"
            <h4>Let Us Help You</h4>
            <ul>
                <li><a href="login.html">Your Account</a></li>
                <li><a href="orders.html">Your Orders</a></li>
                <li><a href="shipping-rates.html">Shipping Rates</a></li>
                <li><a href="returns.html">Returns & Replacements</a></li>
                <li><a href="help-center.html">Help Center</a></li>
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
