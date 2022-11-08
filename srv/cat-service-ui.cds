using CatalogService from './cat-service';


annotate CatalogService.Books with @odata.draft.enabled;

annotate CatalogService.Books with @(UI : {
    HeaderInfo       : {
        TypeName       : 'Book',
        TypeNamePlural : 'Books',
        Title          : {
            $Type : 'UI.DataField',
            Value : title
        }
    },
    SelectionFields  : [
        author_name,
        title
    ],
    LineItem         : [
        {Value : ID},
        {Value : author_name},
        {Value : title},
        {Value : stock},
        {Value : price},
        {Value : createdBy}
    ],
    Facets           : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>Book_details}',
        Target : '@UI.FieldGroup#Main'
    }],
    FieldGroup #Main : {Data : [
        {Value : ID},
        {Value : author_name},
        {Value : title},
        {Value : stock},
        {Value : price},
        {Value : createdBy}
    ]}
});

annotate CatalogService.Books with {
    ID          @(Common.Label : '{i18n>Book_ID}');
    author_name @(Common.Label : '{i18n>Author}');
    title       @(Common.Label : '{i18n>Title}');
    stock       @(Common.Label : '{i18n>Stock}');
    price       @(Common.Label : '{i18n>Price}');
    createdBy   @(Common.Label : '{i18n>Entry_creator}');
}