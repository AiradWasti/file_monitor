
# FileIntegrityMonitoring.ps1

# Define the list of critical files
$criticalFiles = @(
    "C:\Path\To\Critical\File1.txt",
    "C:\Path\To\Critical\File2.txt"
)

# Path to store the hash values
$hashFilePath = "C:\Path\To\Stored\Hashes\file_hashes.json"

# Function to calculate the hash of a file
function Get-FileHashValue {
    param (
        [string]$filePath
    )
    if (Test-Path $filePath) {
        return Get-FileHash -Algorithm SHA256 -Path $filePath | Select-Object -ExpandProperty Hash
    } else {
        Write-Error "File not found: $filePath"
        return $null
    }
}

# Load previously stored hash values
if (Test-Path $hashFilePath) {
    $storedHashes = Get-Content -Path $hashFilePath | ConvertFrom-Json
} else {
    $storedHashes = @{}
}

# Dictionary to store the current hash values
$currentHashes = @{}

# Check each critical file
foreach ($file in $criticalFiles) {
    $currentHash = Get-FileHashValue -filePath $file
    if ($currentHash) {
        $currentHashes[$file] = $currentHash

        # Compare with the stored hash
        if ($storedHashes.ContainsKey($file)) {
            if ($storedHashes[$file] -ne $currentHash) {
                Write-Host "Change detected in file: $file"
            }
        } else {
            Write-Host "New file detected: $file"
        }
    }
}

# Save the current hash values for future comparisons
$currentHashes | ConvertTo-Json | Set-Content -Path $hashFilePath
