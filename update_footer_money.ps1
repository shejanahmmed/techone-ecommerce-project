$oldBlock = @"
            <h4>Make Money with Us</h4>
            <ul>
                <li><a href="#">Sell on TechOne</a></li>
                <li><a href="#">Sell Apps</a></li>
                <li><a href="#">Become an Affiliate</a></li>
                <li><a href="#">Advertise</a></li>
                <li><a href="#">Self-Publish</a></li>
            </ul>
"@

$newBlock = @"
            <h4>Make Money with Us</h4>
            <ul>
                <li><a href="sell.html">Sell on TechOne</a></li>
                <li><a href="sell-apps.html">Sell Apps</a></li>
                <li><a href="affiliate.html">Become an Affiliate</a></li>
                <li><a href="advertise.html">Advertise</a></li>
                <li><a href="self-publish.html">Self-Publish</a></li>
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
