using my.bookshop as my from '../db/data-model';
using { API_BUSINESS_PARTNER as external_BP } from './external/API_BUSINESS_PARTNER';

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

service ExternalService {
    entity API_BP as projection on external_BP.A_BusinessPartner {
        BusinessPartner,
        Customer,
        Supplier,
        AcademicTitle,
        AuthorizationGroup,
        BusinessPartnerCategory,
        BusinessPartnerFullName,
        BusinessPartnerGrouping,
        BusinessPartnerName
    };
}
