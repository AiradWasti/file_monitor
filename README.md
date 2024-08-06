# File Integrity Monitoring 

The FileIntegrityMonitoring.ps1 script is designed to monitor the integrity of critical files by calculating and comparing their hash values to detect any unauthorized changes. The script starts by defining a list of critical files that need monitoring and specifying a path to store the hash values of these files in a JSON file.

The Get-FileHashValue function calculates the SHA256 hash of a given file, returning the hash value if the file exists or logging an error if the file is not found. The script then attempts to load previously stored hash values from the specified JSON file. If the file does not exist, an empty dictionary is initialized to hold the hash values.

For each critical file, the script calculates the current hash value and stores it in a dictionary. It then compares this current hash value with the stored hash value from the previous run. If a discrepancy is detected, indicating a change in the file, the script outputs a message indicating the change. If a new file is detected (i.e., one that did not have a stored hash value previously), the script also logs this information.

Finally, the script saves the current hash values to the JSON file for use in future comparisons. This enables ongoing monitoring of file integrity, helping to identify and alert on potential tampering or unauthorized modifications to critical files.
