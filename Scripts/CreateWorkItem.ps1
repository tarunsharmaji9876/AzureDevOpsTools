#Authentication in Azure DevOps
$AzureDevOpsPAT = 'cwcujbvivlkxjaetuzxkyhimbufbmhua6to24aqwoowr2rvcl6pa'
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
$ProjectName = "API";


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
    `"path`": `"/fields/System.AreaPath`",
    `"value`": `"API`"
  }
  
]"

Invoke-RestMethod -Uri $uri -Method POST -Headers $AzureDevOpsAuthenicationHeader -ContentType "application/json-patch+json" -Body $body
