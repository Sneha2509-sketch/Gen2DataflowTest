[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Append"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared DefaultDestination = Fabric.Warehouse([CreateNavigationProperties = false]){[workspaceId = "07928a92-e295-440d-8797-fca31eec10e4"]}[Data]{[warehouseId = "99f1b136-7689-4fb9-8671-98596be86f3c"]}[Data];
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "SampleAudit_DailySnapshot_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "id", DestinationColumnName = "id"], [SourceColumnName = "date", DestinationColumnName = "date"], [SourceColumnName = "Status", DestinationColumnName = "Status"]}], DynamicSchema = false, UpdateMethod = [Kind = "Append"], TypeSettings = [Kind = "Table"]]]}]
shared SampleAudit_DailySnapshot = let
  Source = PostgreSQL.Database("localhost", DBName, [Query = "SELECT id,  now()- interval '5 hour' as Date,#(lf)CASE #(lf)WHEN status_code = 'sample.piece.status.received' THEN 'Received'#(lf)WHEN status_code='sample.piece.status.assembled' THEN 'Assembled'#(lf)WHEN status_code='sample.piece.status.request.disposal' THEN 'Request Disposal'#(lf)ELSE 'Transferred'#(lf)END AS ""Status""#(lf)FROM trutesta_sampletracker.sample_piece  #(lf)where status_code in ('sample.piece.status.received', 'sample.piece.status.assembled', 'sample.piece.status.request.disposal', 'sample.piece.status.transferred')#(lf)", CreateNavigationProperties = false]),
  #"Changed column type" = Table.TransformColumnTypes(Source, {{"date", type date}})
in
  #"Changed column type";
shared DBName = "gbs-trutesta-sandbox" meta [IsParameterQuery = true, IsParameterQueryRequired = false, Type = type text, List = {"gbs-trutesta-sandbox", "gbs-trutesta-production"}, DefaultValue = "gbs-trutesta-sandbox"];
shared SampleAudit_DailySnapshot_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "07928a92-e295-440d-8797-fca31eec10e4"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "99f1b136-7689-4fb9-8671-98596be86f3c"]}[Data],
  TableNavigation = Navigation_2{[Item = "SampleAudit_DailySnapshot", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
