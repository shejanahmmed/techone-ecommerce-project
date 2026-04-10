$oldBlock = @"
            <h4>Get to Know Us</h4>
            <ul>
                <li><a href="#">Careers</a></li>
                <li><a href="#">Blog</a></li>
                <li><a href="#">About TechOne</a></li>
                <li><a href="#">Press Center</a></li>
                <li><a href="#">Investor Relations</a></li>
            </ul>
"@

$newBlock = @"
            <h4>Get to Know Us</h4>
            <ul>
                <li><a href="careers.html">Careers</a></li>
                <li><a href="blog.html">Blog</a></li>
                <li><a href="about.html">About TechOne</a></li>
                <li><a href="press.html">Press Center</a></li>
                <li><a href="investors.html">Investor Relations</a></li>
            </ul>
"@

$files = Get-ChildItem -Filter *.html
foreach ($file in $files) {
    if ($file.Name -ne "scratch") {
        $content = Get-Content -Raw -Path $file.FullName
        # Normalize line endings just in case
        $normalizedContent = $content -replace "`r`n", "`n"
        $normalizedOldBlock = $oldBlock -replace "`r`n", "`n"
        
        if ($normalizedContent.Contains($normalizedOldBlock)) {
            $newContent = $normalizedContent.Replace($normalizedOldBlock, $newBlock)
            Set-Content -Path $file.FullName -Value $newContent
        }
    }
}
