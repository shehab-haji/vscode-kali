# vscode-kali
Installing Visual Studio Code on Kali Linux (2025 — Verified Repository Method)
A clean, secure way to install Microsoft Visual Studio Code on Kali Linux using Microsoft’s official APT repository.
Tested on Kali Linux 2024–2025 releases.
#Test
```sudo apt update && sudo apt upgrade -y
sudo install -d -m 0755 /etc/apt/keyrings

curl -fsSL -o /tmp/ms.key.asc https://packages.microsoft.com/keys/microsoft.asc
sudo gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg /tmp/ms.key.asc
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main' \
 | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y code
code


If Microsoft rotates keys (e.g., publishes microsoft-2025.asc or microsoft-rolling.asc), replace the URL in the curl line with the new one and repeat.

>Why this method?

Secure: Packages are verified with Microsoft’s PGP key.

Convenient: Future updates arrive via apt upgrade.

Modern layout: Uses /etc/apt/keyrings and signed-by= for per-repo trust.

Step-by-step
1) Update the system
sudo apt update
sudo apt upgrade -y

2) Fetch Microsoft’s public signing key
sudo install -d -m 0755 /etc/apt/keyrings
curl -fsSL -o /tmp/ms.key.asc https://packages.microsoft.com/keys/microsoft.asc
# If Microsoft announces a new key (e.g., microsoft-2025.asc or microsoft-rolling.asc),
# replace the URL accordingly and use that file instead.


Confirm it’s a real key:

head -n2 /tmp/ms.key.asc
tail -n2 /tmp/ms.key.asc
# You should see the BEGIN/END PGP PUBLIC KEY BLOCK lines.

3) Convert to binary keyring
sudo gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg /tmp/ms.key.asc
sudo chmod 0644 /etc/apt/keyrings/microsoft.gpg

4) Add the repository
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main' \
 | sudo tee /etc/apt/sources.list.d/vscode.list

5) Update and install VS Code
sudo apt update
sudo apt install -y code

6) Run VS Code
code

Troubleshooting

“no valid OpenPGP data found”
You likely downloaded HTML (redirect/readme) instead of the key. Save first, then inspect:

curl -I https://packages.microsoft.com/keys/microsoft.asc
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | head -n 3


Ensure it begins with -----BEGIN PGP PUBLIC KEY BLOCK-----.
If Microsoft documents a new key (e.g., microsoft-2025.asc), use that URL.

Signature errors on apt update
Recreate the keyring:

sudo rm -f /etc/apt/keyrings/microsoft.gpg
sudo gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg /tmp/ms.key.asc
sudo apt update


Using /usr/share/keyrings/ vs /etc/apt/keyrings/
Modern Debian/Kali recommend /etc/apt/keyrings/ for admin-added keys.
/usr/share/keyrings/ is typically for OS-provided keyring packages.

Notes

The signed-by= option limits trust of the Microsoft key only to this repository.

Future updates will come via:

sudo apt update && sudo apt upgrade


If you installed VS Code previously via .deb, remove it before switching to the repository method:

sudo apt remove --purge code
sudo apt autoremove -y
