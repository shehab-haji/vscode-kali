sudo apt update && sudo apt upgrade -y
sudo install -d -m 0755 /etc/apt/keyrings
curl -fsSL -o /tmp/ms.key.asc https://packages.microsoft.com/keys/microsoft.asc
sudo gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg /tmp/ms.key.asc
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main' \
 | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y code
code
