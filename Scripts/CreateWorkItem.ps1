#Authentication in Azure DevOps
$AzureDevOpsPAT = 't2h5a3sdajeh6ma3v6ey4x4nnln2gcxkxvmugkdpjvbxfkt5arza'
$AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }

$OrganizationName = "mrsharma2607"
$UriOrganization = "https://dev.azure.com/$($OrganizationName)/"

#Lists all projects in your organization
$uriAccount = $UriOrganization + "_apis/projects?api-version=5.1"
Invoke-RestMethod -Uri $uriAccount -Method get -Headers $AzureDevOpsAuthenicationHeader 


#Create a work item

$WorkItemType = "Task"
$WorkItemTitle = "Test from Powershell"
$WorkItemDescription = "Task creation"
$ProjectName = "test_code";


$uri = $UriOrganization + $ProjectName + "/_apis/wit/workitems/$" + $WorkItemType + "?api-version=5.1"
echo $uri

$body="[
  {
    `"op`": `"add`",
    `"path`": `"/fields/System.Title`",
    `"value`": `"$($WorkItemTitle)`"
  },
  {
    `"op`": `"add`",
    `"path`": `"/fields/System.AssignedTo`",
    `"from`": null,
    `"value`": `"tarunsharmaji9876@gmail.com`"
  },
  {
    `"op`": `"add`",
    `"path`": `"/fields/System.Description`",
    `"from`": null,
    `"value`": `"$($WorkItemDescription)`"
  },
    {
    `"op`": `"add`",
    `"path`": `"/fields/System.Discussion`",
    `"from`": null,
    `"value`": `"Remaining work of Task"
  },
  {
    `"op`": `"add`",
    `"path`": `"/fields/System.AreaPath`",
    `"value`": `"test_code`"
  }
]"

Invoke-RestMethod -Uri $uri -Method POST -Headers $AzureDevOpsAuthenicationHeader -ContentType "application/json-patch+json" -Body $body
