#Authentication in Azure DevOps
$AzureDevOpsPAT = 'mjky42gwwnth5rtbqgjxnzhxlb7krvqvhfageo52ejquk3ktjedq'
$AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }

$OrganizationName = "ChirumamillaA"
$UriOrganization = "https://dev.azure.com/$($OrganizationName)/"

#Lists all projects in your organization
$uriAccount = $UriOrganization + "_apis/projects?api-version=5.1"
Invoke-RestMethod -Uri $uriAccount -Method get -Headers $AzureDevOpsAuthenicationHeader 


#Create a work item

$WorkItemType = "feature"
$WorkItemTitle = "Test from Powershell"
$ProjectName = "apicall";


$uri = $UriOrganization + $ProjectName + "/_apis/wit/workitems/$" + $WorkItemType + "?api-version=5.1"
echo $uri

$body="[
  {
    `"op`": `"add`",
    `"path`": `"/fields/System.Title`",
    `"value`": `"$($WorkItemTitle)`"
  }
]"

Invoke-RestMethod -Uri $uri -Method POST -Headers $AzureDevOpsAuthenicationHeader -ContentType "application/json-patch+json" -Body $body
