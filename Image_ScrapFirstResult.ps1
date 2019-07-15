# Scraps the first result of a google image search.

$name = Read-Host -Prompt 'Le nom de lentreprise'
$name = $name + " logo"

Write-Host "Searching for $name."

$link = "https://www.google.com/search?hl=fr&tbm=isch&source=hp&biw=1922&bih=944&ei=kdisW42aF6eMlwSCrImYAQ&q=$name&gs_l=img.3..0l10.2991.3670.0.3937.8.8.0.0.0.0.149.810.3j5.8.0....0...1ac.1.64.img..0.8.808....0.VGbSnF79cvM"

$res = Invoke-WebRequest -Uri $link -UseBasicParsing

$image = $res.images[0].src

Invoke-WebRequest -Uri $image -OutFile "C:\path\image.png" 

Write-Host "Image stored in C:\path\image.png."