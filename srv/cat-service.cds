using my.bookshop as my from '../db/data-model';

service CatalogService @(requires : 'authenticated-user') {

    entity Authors @(restrict : [
        {
            grant : ['READ'],
            to    : ['authenticated-user'],
            where : 'nationality = $user.country'
        },
        {
            grant : ['*'],
            to    : ['Admin']
        }
    ]) as projection on my.Authors;

    entity Books @(restrict : [
        {
            grant : ['READ'],
            to    : ['authenticated-user']
        },
        {
            grant : ['*'],
            to    : ['Admin']
        }
    ]) as projection on my.Books {
        *,
        author.name as author_name
    };

    function totalStock()                                     returns Integer;

    action   submitOrder(book : Books:ID, quantity : Integer) returns {
        stock : Integer
    };

}

service PublicService   {
    entity Authors as projection on my.Authors;
    entity Books as projection on my.Authors;
}