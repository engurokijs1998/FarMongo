<#
.Synopsis
	Shows MongoDB databases, collections, views, documents.

.Description
	This command connects MongoDB and shows databases, collections, views,
	documents including nested documents and arrays. Root documents may be
	viewed and edited as JSON. Nested documents may not be edited directly.

	Paging. Large collections is not a problem. Documents are shown 1000/page.
	Press [PgDn]/[PgUp] at last/first panel items to show next/previous pages.

	Aggregation pipelines may be defined for custom panel views of collections.
	If result documents have the same _id as the source collection then they
	are edited and deleted in the source collection from this custom view.

	KEYS AND ACTIONS

	[Del]
		Deletes selected documents and empty databases, collections, views.
		For deleting not empty containers use [ShiftDel].

	[ShiftDel]
		Deletes selected databases, collections, views, documents.

	[ShiftF6]
		Prompts for a new name and renames the current collection.

.Parameter ConnectionString
		Specifies the connection string. Use "." for the default local server.
		If DatabaseName and CollectionName are omitted then the panel shows
		databases.

.Parameter DatabaseName
		Specifies the database name. If CollectionName is omitted then the
		panel shows this database collections.

.Parameter CollectionName
		Specifies the collection name and tells to show collection documents.
		This parameter must be used together with DatabaseName. Use Pipeline
		in order to customise the view of this collection in the panel.

.Parameter Pipeline
		Aggregation pipeline for the custom view of the specified collection.

.Example
	Open-MongoPanel

	This command shows local databases in the panel.

.Example
	Open-MongoPanel . myDatabase

	This command shows collections of "myDatabase".

.Example
	Open-MongoPanel . myDatabase myCollection

	This command shows documents of "myDatabase.myCollection".
#>
function Open-MongoPanel {
	[CmdletBinding()]
	param(
		[string]$ConnectionString = '.',
		[string]$DatabaseName,
		[string]$CollectionName,
		$Pipeline
	)

	if ($CollectionName) {
		Connect-Mdbc $ConnectionString $DataBaseName $CollectionName
		(New-FMCollectionExplorer $Collection $Pipeline).OpenPanel()
	}
	elseif ($DatabaseName) {
		Connect-Mdbc $ConnectionString $DatabaseName
		(New-FMDatabaseExplorer $Database).OpenPanel()
	}
	else {
		(New-FMServerExplorer $ConnectionString).OpenPanel()
	}
}