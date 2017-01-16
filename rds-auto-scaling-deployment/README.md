# Deploy RDS Auto-Scaling Script on RDS Connection Broker

This template deploys RDS Auto-Scaling script to RDS Connection Broker VM in a RDS environment

The template does the following:
+	check Azure Powershell module is installed or not, if not, it will install the Azure Powershell module;
+   deploy the RDS auto-scaling script along with the configuration from a given web location to a specified folder on c drive;
+	create a scheduled task running at specified interval.


### Prerequisites

Existing rds connection broker virtual machine. for HA connection broker, run the template for each connection broker vm:


Click the button below to deploy

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAlan-AcutePath%2Fazure-quickstart-templates%2Fmaster%2Frds-auto-scaling-deployment%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAlan-AcutePath%2Fazure-quickstart-templates%2Fmaster%2Frds-auto-scaling-deployment%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>
