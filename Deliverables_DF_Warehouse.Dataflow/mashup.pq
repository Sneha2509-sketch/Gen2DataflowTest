section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "deliverable_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "id", DestinationColumnName = "id"], [SourceColumnName = "name_text", DestinationColumnName = "name_text"], [SourceColumnName = "description", DestinationColumnName = "description"], [SourceColumnName = "deliverable_type_id", DestinationColumnName = "deliverable_type_id"], [SourceColumnName = "transacting_customer_display_name", DestinationColumnName = "transacting_customer_display_name"], [SourceColumnName = "receive_customer_id", DestinationColumnName = "receive_customer_id"], [SourceColumnName = "receive_customer_display_name", DestinationColumnName = "receive_customer_display_name"], [SourceColumnName = "deliverable_state", DestinationColumnName = "deliverable_state"], [SourceColumnName = "date_issued", DestinationColumnName = "date_issued"], [SourceColumnName = "date_revised", DestinationColumnName = "date_revised"], [SourceColumnName = "date_created", DestinationColumnName = "date_created"], [SourceColumnName = "date_last_updated", DestinationColumnName = "date_last_updated"], [SourceColumnName = "products_covered", DestinationColumnName = "products_covered"], [SourceColumnName = "is_legacy", DestinationColumnName = "is_legacy"], [SourceColumnName = "formatted_standards", DestinationColumnName = "formatted_standards"], [SourceColumnName = "project_number", DestinationColumnName = "project_number"], [SourceColumnName = "date_withdrawn", DestinationColumnName = "date_withdrawn"], [SourceColumnName = "date_under_revision", DestinationColumnName = "date_under_revision"], [SourceColumnName = "revision_project_number", DestinationColumnName = "revision_project_number"], [SourceColumnName = "models", DestinationColumnName = "models"], [SourceColumnName = "engineering_resource_name", DestinationColumnName = "engineering_resource_name"], [SourceColumnName = "reviewer_resource_name", DestinationColumnName = "reviewer_resource_name"], [SourceColumnName = "receiving_customer_code", DestinationColumnName = "receiving_customer_code"], [SourceColumnName = "search_name", DestinationColumnName = "search_name"], [SourceColumnName = "issuing_organization_name", DestinationColumnName = "issuing_organization_name"], [SourceColumnName = "responsible_organization_name", DestinationColumnName = "responsible_organization_name"], [SourceColumnName = "reviewer_organization_name", DestinationColumnName = "reviewer_organization_name"], [SourceColumnName = "date_made_official", DestinationColumnName = "date_made_official"], [SourceColumnName = "date_expires", DestinationColumnName = "date_expires"], [SourceColumnName = "date_hold", DestinationColumnName = "date_hold"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared deliverable = let
  Source = PostgreSQL.Database("localhost", DBName, [CommandTimeout = #duration(0, 0, 5, 0), CreateNavigationProperties = false]),
  #"Navigation 1" = Source{[Schema = "trutesta_client_deliverable", Item = "deliverable"]}[Data],
  #"Removed other columns" = Table.SelectColumns(#"Navigation 1", {"id", "name_text", "description", "deliverable_type_id", "transacting_customer_display_name", "receive_customer_id", "receive_customer_display_name", "deliverable_state", "date_issued", "date_revised", "date_created", "date_last_updated", "products_covered", "is_legacy", "formatted_standards", "project_number", "date_withdrawn", "date_under_revision", "revision_project_number", "models", "engineering_resource_name", "reviewer_resource_name", "receiving_customer_code", "search_name", "issuing_organization_name", "responsible_organization_name", "reviewer_organization_name", "date_made_official", "date_expires", "date_hold"}),
  #"Filtered rows" = if limitRows then Table.SelectRows(#"Removed other columns", each Date.IsInPreviousNYears([date_created], 1)) else #"Removed other columns"
in
  #"Filtered rows";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "deliverable_type_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "id", DestinationColumnName = "id"], [SourceColumnName = "tenant_id", DestinationColumnName = "tenant_id"], [SourceColumnName = "name_text", DestinationColumnName = "name_text"], [SourceColumnName = "business_code", DestinationColumnName = "business_code"], [SourceColumnName = "description", DestinationColumnName = "description"], [SourceColumnName = "status", DestinationColumnName = "status"], [SourceColumnName = "date_created", DestinationColumnName = "date_created"], [SourceColumnName = "created_by_name", DestinationColumnName = "created_by_name"], [SourceColumnName = "date_last_updated", DestinationColumnName = "date_last_updated"], [SourceColumnName = "lastupdated_by_name", DestinationColumnName = "lastupdated_by_name"], [SourceColumnName = "deliverable_category", DestinationColumnName = "deliverable_category"], [SourceColumnName = "requires_tags", DestinationColumnName = "requires_tags"], [SourceColumnName = "can_be_revised", DestinationColumnName = "can_be_revised"], [SourceColumnName = "expire_duration", DestinationColumnName = "expire_duration"], [SourceColumnName = "approval_review_workflow_id", DestinationColumnName = "approval_review_workflow_id"], [SourceColumnName = "approval_review_workflow_revision_id", DestinationColumnName = "approval_review_workflow_revision_id"], [SourceColumnName = "supports_approval_workflow", DestinationColumnName = "supports_approval_workflow"], [SourceColumnName = "deliverable_name_case", DestinationColumnName = "deliverable_name_case"], [SourceColumnName = "deliverable_name_reg_ex", DestinationColumnName = "deliverable_name_reg_ex"], [SourceColumnName = "document_placeholder_template_group_id", DestinationColumnName = "document_placeholder_template_group_id"], [SourceColumnName = "template_library_id", DestinationColumnName = "template_library_id"], [SourceColumnName = "template_tag_id", DestinationColumnName = "template_tag_id"], [SourceColumnName = "template_id", DestinationColumnName = "template_id"], [SourceColumnName = "checklist_id", DestinationColumnName = "checklist_id"], [SourceColumnName = "deliverable_expiration_policy_id", DestinationColumnName = "deliverable_expiration_policy_id"], [SourceColumnName = "document_upload_policy_id", DestinationColumnName = "document_upload_policy_id"], [SourceColumnName = "revision_rule_id", DestinationColumnName = "revision_rule_id"], [SourceColumnName = "is_type_certification", DestinationColumnName = "is_type_certification"], [SourceColumnName = "surveillance_policy_id", DestinationColumnName = "surveillance_policy_id"], [SourceColumnName = "report_revision_form_id", DestinationColumnName = "report_revision_form_id"], [SourceColumnName = "audit_entity_component_scheme_id", DestinationColumnName = "audit_entity_component_scheme_id"], [SourceColumnName = "supports_internal_audits", DestinationColumnName = "supports_internal_audits"], [SourceColumnName = "supports_external_audits", DestinationColumnName = "supports_external_audits"], [SourceColumnName = "allow_report_metadata_integration", DestinationColumnName = "allow_report_metadata_integration"], [SourceColumnName = "supports_product_ratings", DestinationColumnName = "supports_product_ratings"], [SourceColumnName = "product_rating_set_id", DestinationColumnName = "product_rating_set_id"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared deliverable_type = let
  Source = PostgreSQL.Database("localhost", DBName, [CommandTimeout = #duration(0, 0, 5, 0), CreateNavigationProperties = false]),
  #"Navigation 1" = Source{[Schema = "trutesta_client_deliverable", Item = "deliverable_type"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 1", {"deliverable_watermark_policy_id", "resource_library_id", "checklist_document_id"})
in
  #"Removed columns";
shared DeliverableDFLastUpdate = let
    Source = DateTimeZone.UtcNow(),
    #"Convert to table" = Table.FromValue(Source),
    #"Renamed columns" = Table.RenameColumns(#"Convert to table", {{"Value", "Updated Time in UTC"}})
in
    #"Renamed columns";
shared DBName = "gbs-trutesta-sandbox" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text, List = {"gbs-trutesta-sandbox", "gbs-trutesta-production", "gbs-trutesta-qa"}, DefaultValue = "gbs-trutesta-qa"];
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "deliverable_hold_reason_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "id", DestinationColumnName = "id"], [SourceColumnName = "tenant_id", DestinationColumnName = "tenant_id"], [SourceColumnName = "name_text", DestinationColumnName = "name_text"], [SourceColumnName = "business_code", DestinationColumnName = "business_code"], [SourceColumnName = "description", DestinationColumnName = "description"], [SourceColumnName = "status", DestinationColumnName = "status"], [SourceColumnName = "date_created", DestinationColumnName = "date_created"], [SourceColumnName = "created_by_name", DestinationColumnName = "created_by_name"], [SourceColumnName = "date_last_updated", DestinationColumnName = "date_last_updated"], [SourceColumnName = "lastupdated_by_name", DestinationColumnName = "lastupdated_by_name"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared deliverable_hold_reason = let
  Source = PostgreSQL.Database("localhost", DBName, [CreateNavigationProperties = false]),
  #"Navigation 1" = Source{[Schema = "trutesta_client_deliverable", Item = "deliverable_hold_reason"]}[Data]
in
  #"Navigation 1";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "DeliverableOwnershipGroup_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "deliverable_id", DestinationColumnName = "deliverable_id"], [SourceColumnName = "ownership_group_id", DestinationColumnName = "ownership_group_id"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared DeliverableOwnershipGroup = let
  Source = PostgreSQL.Database("localhost", DBName, [CommandTimeout = #duration(0, 0, 3, 0), Query = "select distinct deliverable_ownership_group.deliverable_id, deliverable_ownership_group.ownership_group_id#(lf)FROM trutesta_client_deliverable.deliverable_ownership_group#(lf)"])
in
  Source;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "ownership_group_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "id", DestinationColumnName = "id"], [SourceColumnName = "tenant_id", DestinationColumnName = "tenant_id"], [SourceColumnName = "name_text", DestinationColumnName = "name_text"], [SourceColumnName = "business_code", DestinationColumnName = "business_code"], [SourceColumnName = "description", DestinationColumnName = "description"], [SourceColumnName = "status", DestinationColumnName = "status"], [SourceColumnName = "date_created", DestinationColumnName = "date_created"], [SourceColumnName = "created_by_name", DestinationColumnName = "created_by_name"], [SourceColumnName = "date_last_updated", DestinationColumnName = "date_last_updated"], [SourceColumnName = "lastupdated_by_name", DestinationColumnName = "lastupdated_by_name"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared ownership_group = let
  Source = PostgreSQL.Database("localhost", DBName, [CreateNavigationProperties = false]),
  Navigation = Source{[Schema = "trutesta_client_deliverable", Item = "ownership_group"]}[Data]
in
  Navigation;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "DeliverableUser_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "deliverable_id", DestinationColumnName = "deliverable_id"], [SourceColumnName = "tenant_user_id", DestinationColumnName = "tenant_user_id"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared DeliverableUser = let
  Source = PostgreSQL.Database("localhost", DBName, [CommandTimeout = #duration(0, 0, 3, 0), Query = "select distinct deliverable_ownership_group.deliverable_id, ownership_group_user.tenant_user_id#(lf)FROM trutesta_client_deliverable.deliverable_ownership_group#(lf)INNER JOIN trutesta_client_deliverable.ownership_group ON ownership_group.id = deliverable_ownership_group.ownership_group_id#(lf)INNER JOIN trutesta_client_deliverable.ownership_group_user ON ownership_group_user.ownership_group_id = ownership_group.id "])
in
  Source;
shared Version = "1.0.3" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text];
shared Deliverables_DF_Version = let
  Source = Version,
  #"Converted to Table" = #table(1, {{Source}}),
  #"Renamed Columns" = Table.RenameColumns(#"Converted to Table", {{"Column1", "Version"}}),
  #"Transform columns" = Table.TransformColumnTypes(#"Renamed Columns", {{"Version", type text}}),
  #"Replace errors" = Table.ReplaceErrorValues(#"Transform columns", {{"Version", null}})
in
  #"Replace errors";
shared Deliverables_DF_DBName = let
  Source = DBName,
  #"Converted to Table" = #table(1, {{Source}}),
  #"Renamed Columns" = Table.RenameColumns(#"Converted to Table", {{"Column1", "DBName"}}),
  #"Transform columns" = Table.TransformColumnTypes(#"Renamed Columns", {{"DBName", type text}}),
  #"Replace errors" = Table.ReplaceErrorValues(#"Transform columns", {{"DBName", null}})
in
  #"Replace errors";
shared limitRows = false meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type logical, List = {true, false}, DefaultValue = true];
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "deliverable_tag_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "deliverable_id", DestinationColumnName = "deliverable_id"], [SourceColumnName = "tag", DestinationColumnName = "tag"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared deliverable_tag = let
  Source = PostgreSQL.Database("localhost", DBName, [CreateNavigationProperties = false]),
  #"Navigation 1" = Source{[Schema = "trutesta_client_deliverable", Item = "deliverable_tag"]}[Data],
  #"Grouped rows" = Table.Group(#"Navigation 1", {"deliverable_id"}, {{"tags", each _, type nullable table[id = text, tenant_id = text, deliverable_id = text, tag_name = text, date_created = datetime, created_by_name = nullable text, date_last_updated = nullable datetime, lastupdated_by_name = nullable text]}}),
  #"Added custom" = Table.AddColumn(#"Grouped rows", "tag", each Text.Combine(List.Sort(List.Transform([tags][tag_name], Text.From)), ", ")),
  #"Removed columns" = Table.RemoveColumns(#"Added custom", {"tags"}),
  #"Transform columns" = Table.TransformColumnTypes(#"Removed columns", {{"tag", type text}}),
  #"Replace errors" = Table.ReplaceErrorValues(#"Transform columns", {{"tag", null}})
in
  #"Replace errors";
shared deliverable_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "25fb9032-d0cf-4f24-a773-73464483b45a"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "65a55d3a-3434-40df-9e36-7b6c57cee01a"]}[Data],
  TableNavigation = Navigation_2{[Item = "deliverable", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared deliverable_type_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "25fb9032-d0cf-4f24-a773-73464483b45a"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "65a55d3a-3434-40df-9e36-7b6c57cee01a"]}[Data],
  TableNavigation = Navigation_2{[Item = "deliverable_type", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared deliverable_hold_reason_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "25fb9032-d0cf-4f24-a773-73464483b45a"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "65a55d3a-3434-40df-9e36-7b6c57cee01a"]}[Data],
  TableNavigation = Navigation_2{[Item = "deliverable_hold_reason", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared DeliverableOwnershipGroup_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "25fb9032-d0cf-4f24-a773-73464483b45a"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "65a55d3a-3434-40df-9e36-7b6c57cee01a"]}[Data],
  TableNavigation = Navigation_2{[Item = "DeliverableOwnershipGroup", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared ownership_group_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "25fb9032-d0cf-4f24-a773-73464483b45a"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "65a55d3a-3434-40df-9e36-7b6c57cee01a"]}[Data],
  TableNavigation = Navigation_2{[Item = "ownership_group", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared DeliverableUser_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "25fb9032-d0cf-4f24-a773-73464483b45a"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "65a55d3a-3434-40df-9e36-7b6c57cee01a"]}[Data],
  TableNavigation = Navigation_2{[Item = "DeliverableUser", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared deliverable_tag_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "25fb9032-d0cf-4f24-a773-73464483b45a"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "65a55d3a-3434-40df-9e36-7b6c57cee01a"]}[Data],
  TableNavigation = Navigation_2{[Item = "deliverable_tag", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
