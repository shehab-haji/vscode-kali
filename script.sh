sudo apt update && sudo apt upgrade -y
sudo install -d -m 0755 /etc/apt/keyrings
curl -fsSL -o microsoft-rolling.asc https://packages.microsoft.com/keys/microsoft.asc
sudo gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg microsoft-rolling.asc
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main' \
 | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y code
code
