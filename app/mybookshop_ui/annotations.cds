using CatalogService as service from '../../srv/cat-service';

annotate CatalogService.Books with @odata.draft.enabled;

annotate CatalogService.Books with @(UI : {
    HeaderInfo      : {
        TypeName       : 'Book',
        TypeNamePlural : 'Books',
        Title          : {
            $Type : 'UI.DataField',
            Value : title
        }
    },
    SelectionFields : [
        author_name,
        title
    ],
    LineItem        : [
        {Value : author_name},
        {Value : title}
    ],
        Facets : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : 'Book details',
        Target : '@UI.FieldGroup#Main'
    }],
    FieldGroup #Main : {Data : [
        {Value : author_name},
        {Value : title}
    ]}

});

annotate CatalogService.Books with {
    author_name @(Common.Label : 'Author');
    title       @(Common.Label : 'Title');
}

