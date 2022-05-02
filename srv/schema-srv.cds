using { PetShop } from '../db/schema';

service CatalogService  {
    entity Pets as projection on PetShop.Pets;
}
