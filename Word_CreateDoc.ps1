$oWord = New-object -com Word.Application
$oWord.Visible = $true
$oMissing = [System.Reflection.Missing]::Value
$oDoc = $oWord.Documents.Add($oMissing, $oMissing, $oMissing, $oMissing)


<#$oPara1 = $oDoc.Paragraphs.Add($oMissing)
$oPara1.Range.Style = "Titre 1"
$oPara1.Range.Text = "Document d'architecture"
$oPara1.Range.InsertParagraphAfter()

$oPara2 = $oDoc.Paragraphs.Add($oMissing)
$oPara2.Range.Text = "Microsoft Word automation is simple with PowerShell"
$oPara2.Range.InsertParagraphAfter()


$oPara3 = $oDoc.Paragraphs.Add($oMissing)
$oPara3.Range.Text = "Microsoft Word automation is simple with PowerShell"
$oPara3.Range.InsertParagraphAfter()#>


function Add-Paragraph {
     param ([string]$text, [string]$style, [string]$pos
    )
    $paragraph = $oDoc.Paragraphs.Add($oMissing)
    if ($style) {
        $paragraph.Range.Style = $style
    }
    <#if ($pos) {
        if ($pos -eq "r"){
           # $paragraph.paragraphs.alignment = wdAlignParagraphRight
        }
        elseif ($pos -eq "c"){
            $paragraph.range.alignment = 1
        }
        else {
            Write-Host "error in pos"
        }
    }#>
    $paragraph.Range.Text = $text
    $paragraph.Range.InsertParagraphAfter()
}
 

function Get-image {

# Gets the name of company, scrap the image from the first result and save. 
    $name = Read-Host -Prompt 'Le nom de lentreprise'
    $name = $name + " logo"
    Write-Host "Searching for $name."
    #$link = "https://www.google.com/search?hl=fr&tbm=isch&source=hp&biw=1922&bih=944&ei=kdisW42aF6eMlwSCrImYAQ&q=$name&gs_l=img.3..0l10.2991.3670.0.3937.8.8.0.0.0.0.149.810.3j5.8.0....0...1ac.1.64.img..0.8.808....0.VGbSnF79cvM"
    #$link = "https://www.google.com/search?q=$name&client=firefox-b-ab&tbm=isch&source=lnt&tbs=isz:m&sa=X&ved=0ahUKEwiq2KiertvdAhUOTBoKHbTKBrIQpwUIHg&biw=1922&bih=944&dpr=1"
    $link = "https://www.google.com/search?q=$name&hl=fr&tbm=isch&source=lnt&tbs=isz:l&sa=X&ved=0ahUKEwihirPzotvdAhUS6RoKHY2fAIUQpwUIHg&biw=1922&bih=944&dpr=1"

    $res = Invoke-WebRequest -Uri $link -UseBasicParsing
    $image = $res.images[0].src

    Invoke-WebRequest -Uri $image -OutFile "C:\path\image.png" 
    Write-Host "Image stored in C:\path\image.png."
}

function Add-Image {
    Get-image
    
    $objshape = $oDoc.InlineShapes.AddPicture("C:\path\image.png")
    #Write-host $objshape.range.Insertparagraphafter()
    $objshape.width = 100
    $objshape.height = 70
}


Add-Paragraph -text "Document d'architecture Intune" -style 'Titre 1' 
Add-Paragraph -text "Réalisé par : Conor Mc Gregor"

Add-Image



