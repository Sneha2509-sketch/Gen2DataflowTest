section Section1;
shared deliverable = let
  Source = PostgreSQL.Database("localhost", DBName, [CommandTimeout = #duration(0, 0, 5, 0), CreateNavigationProperties = false]),
  #"Navigation 1" = Source{[Schema = "trutesta_client_deliverable", Item = "deliverable"]}[Data],
  #"Removed other columns" = Table.SelectColumns(#"Navigation 1", {"id", "name_text", "description", "deliverable_type_id", "transacting_customer_display_name", "receive_customer_id", "receive_customer_display_name", "deliverable_state", "date_issued", "date_revised", "date_created", "date_last_updated", "products_covered", "is_legacy", "formatted_standards", "project_number", "date_withdrawn", "date_under_revision", "revision_project_number", "models", "engineering_resource_name", "reviewer_resource_name", "receiving_customer_code", "search_name", "issuing_organization_name", "responsible_organization_name", "reviewer_organization_name", "date_made_official", "date_expires", "date_hold"}),
  #"Filtered rows" = if limitRows then Table.SelectRows(#"Removed other columns", each Date.IsInPreviousNYears([date_created], 1)) else #"Removed other columns"
in
  #"Filtered rows";
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
shared deliverable_hold_reason = let
  Source = PostgreSQL.Database("localhost", DBName, [CreateNavigationProperties = false]),
  #"Navigation 1" = Source{[Schema = "trutesta_client_deliverable", Item = "deliverable_hold_reason"]}[Data]
in
  #"Navigation 1";
shared DeliverableOwnershipGroup = let
  Source = PostgreSQL.Database("localhost", DBName, [CommandTimeout = #duration(0, 0, 3, 0), Query = "select distinct deliverable_ownership_group.deliverable_id, deliverable_ownership_group.ownership_group_id#(lf)FROM trutesta_client_deliverable.deliverable_ownership_group#(lf)"])
in
  Source;
shared ownership_group = let
  Source = PostgreSQL.Database("localhost", DBName, [CreateNavigationProperties = false]),
  Navigation = Source{[Schema = "trutesta_client_deliverable", Item = "ownership_group"]}[Data]
in
  Navigation;
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
