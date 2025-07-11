#!/bin/bash

sudo yum update -y

# Enable and install from EPEL
sudo amazon-linux-extras install epel -y
sudo yum install -y httpd php stress

sudo systemctl enable httpd
sudo systemctl start httpd

sudo tee /var/www/html/index.php > /dev/null <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <title>Hello Manara</title>
  <style>
    body { font-family: sans-serif; text-align: center; margin-top: 10%; background: #f4f4f4; }
    h1 { font-size: 48px; color: #333; }
    button { padding: 10px 20px; font-size: 18px; }
  </style>
</head>
<body>
  <h1>Hello, Manara! 👋</h1>
  <form method="post">
    <button name="stress" type="submit">Stress EC2 CPU</button>
  </form>
  <pre>
<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['stress'])) {
    echo "Running: /usr/bin/stress --cpu 2 --timeout 300\n";
    echo shell_exec("/usr/bin/stress --cpu 2 --timeout 300 2>&1");
}
?>
  </pre>
</body>
</html>
EOF

sudo chown apache:apache /var/www/html/index.php
sudo chmod 644 /var/www/html/index.php
