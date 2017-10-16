param(
    [string] $Destdir = ".",
    [string[]] $max
)

# Constants
$OpenSCADLocation = (Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OpenSCAD -Name UninstallString).UninstallString | Split-Path -Parent

# Utility functions
function Parse-Patsubst ($patsubst) {
    $pattern, $replace, $text = $patsubst -split ","
    # Determine which shell command is in the text
    switch -regex ($text) {
        '\$\(shell\s+seq\s+1\s+\$\(MAX_(\w+)\)\)'
        {
            # numeric sequences
            $text = 1..$maxval[$matches[1]]
        }
        '\$\(shell\s+./letterseq.pl\s+\$\(MAX_(\w+)\)\)'
        {
            # letter sequences
            $text = [char[]]([int][char]'A'..([int][char]'A' + $maxval[$matches[1]] - 1))
        }
    }
    $rxpattern = $pattern -replace '%', '(\S+)'
    $rxreplace = $replace -replace '%', '$1'
    $text -replace $rxpattern, $rxreplace
}

function Convert-PatternToRegex ($pattern) {
    $pattern -replace '[$().]', "\$&" -replace "%", "(\w+)"
}

# Initial processing of command line arguments
$maxval = @{}
$max | ForEach-Object {
    $i, $val = $_ -split '\s*=\s*'
    $maxval[$i.ToUpper()] = $val
}

# Read in the files to build from the Makefile
$makefile = Get-Content Makefile
$files = @()
$rules = @{}
for($i = 0; $i -lt $makefile.Length; $i++) {
    # Connect lines that end in backslash
    $line = $makefile[$i]
    while($line.EndsWith("\")) {
        $line = $line.Substring(0, $line.Length - 1) + $makefile[++$i]
    }
    # Parse the connected line
    switch -regex ($line) {
        '^MAX_([\w]+)\s*=\s*(.+)$'
        {
            # maximum number of certain tokens
            if($maxval[$matches[1]] -eq $null) { # only set from Makefile if we didn't prepopulate a non-default value
                $maxval[$matches[1]] = $matches[2]
            }
        }
        'STL_FILES\s*:=\s*(.+)$'
        {
            # all the files to build
            $f = $matches[1]
            while($f -match '^(.*?)\$\(patsubst\s+(.*?)\)(\s+.*)$') {
                $result = Parse-Patsubst ($matches[2])
                $f = $matches[1] + $result + $matches[3]
            }
            $files = -split $f
        }
        '^(\S+):\s*(.*)\s+common.scad$'
        {
            # a rule
            $rule = @{ Input = $matches[2]; Output = $matches[1] }
            $rules[$matches[1]] = $rule
            # now read in command if next line starts with a tab
            if($makefile[$i + 1].StartsWith("`t")) {
                $rule.Command = $makefile[++$i].Trim()
            }
        }
    }
}

# Determine which rule should build each file
$ruleforfile = @{}
$rulenames = $rules.Keys -join ',' -split ','
$files | ForEach-Object {
    $f = $_
    $rmatch = $rulenames | ForEach-Object {
        $rx = Convert-PatternToRegex $_
        if($f -match $rx) {
            $matches[1].Length
        } else {
            [int]::MaxValue # Arbitrarily high number
        }
    }
    $rmin = [int]($rmatch | measure -Minimum).Minimum
    if($rmin -lt [int]::MaxValue) {
        $rindex = $rmatch.IndexOf($rmin)
        $ruleforfile[$f] = $rules[$rulenames[$rindex]]
    }
}

# Determine which files need to be rebuilt
$files | ForEach-Object {
    $rule = $ruleforfile[$_]
    $rxoutput = Convert-PatternToRegex $rule.Output
    if($_ -match $rxoutput) {
        $percent = $matches[1]
        $srcfile = $rule.Input -replace "%", $percent
        $destfile = $_ -replace '\$\(DESTDIR\)', $Destdir
        $srctime = (Get-ItemProperty -Path $srcfile -ErrorAction SilentlyContinue).LastWriteTime
        $desttime = (Get-ItemProperty -Path $destfile -ErrorAction SilentlyContinue).LastWriteTime
        if($desttime -eq $null -or $desttime -lt $srctime) {
            $commandArgs = $rule.Command -replace '^openscad\s+', '' -replace '\$\<', $srcfile -replace '\$\@', $destfile -replace '\$\*', $percent -replace '"', '\"' -replace "`'", "`""
            Write-Output "`"$OpenSCADLocation\openscad.com`" $commandArgs"
            $commandArgArray = $commandArgs -split '\s+'
            & "$OpenSCADLocation\openscad.com" $commandArgArray
            if ($LastExitCode -ne 0) {
                throw "Command failed with exit code $LastExitCode."
            }
        }
    }
}
