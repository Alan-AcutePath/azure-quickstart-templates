# Deploy RDS Auto-Scaling Script on RDS Connection Broker

This template deploys new Connection Broker VM and configures existing and new 
[Connection Brokers for High Availability](https://technet.microsoft.com/en-us/windows-server-docs/compute/remote-desktop-services/use-an-azure-sql-database-to-enable-high-availability-for-your-connection-broker).

The template does the following:
+	creates new virtual machine for secondary Connection Broker and joins it to the domain;
+   installs SQL Server Native client on both Borkers;
+	configures Connection Broker for High Availability and adds second Broker to the RDS deployment.
+	adds a DNS entry for the HA Connection Brokers


### Prerequisites

HA Broker Template is an extension to the Basic-RDS-Deployment and it is mandatory to deploy any one of the template as prerequisite:

* Basic RDS deployment template  
  https://github.com/Azure/azure-quickstart-templates/tree/master/rds-deployment 

* RDS deployment from custom RDSH image  
  https://github.com/Azure/azure-quickstart-templates/tree/master/rds-deployment-custom-image-rdsh

* RDS deployment on pre-existing VNET and AD  
  https://github.com/Azure/azure-quickstart-templates/tree/master/rds-deployment-existing-ad
   
A dedicated SQL server or an Azure SQL Database must be created and configured, Template takes 
database connection string as a parameter. 


Sample database connection string:  
`Driver={SQL Server Native Client 11.0};Server=tcp:azuresqldb01.database.windows.net,1433;Database=sql_rddb;Uid=<your username here>@azuresqldb01;Pwd=<your password here>;Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;`

Click the button below to deploy

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmmarch%2Fazure-quickstart-templates%2Fha-broker-template%2Frds-deployment-ha-connectionbroker%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fmmarch%2Fazure-quickstart-templates%2Fha-broker-template%2Frds-deployment-ha-connectionbroker%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>
