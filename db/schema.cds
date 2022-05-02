using {cuid} from '@sap/cds/common';

namespace PetShop;

type specieType : String enum {
    cat;
    dog;
    exotic
}

aspect fullname {
    firstname : String(30);
    lastname  : String(30);
};

entity Pets : cuid, fullname {
    specie    : specieType;
    owner     : Association to one Owners
                    on owner.pet = $self; // Si borro la mascota, no se borran los dueños
    diagnoses : Composition of many Diagnoses
                    on diagnoses.pet = $self; //Si borro una mascota, se borran los diagnósticos
    vets: Association to many Pets_Vet on vets.pet = $self;
};

entity Vets : fullname {
    key id      : Integer;
        license : String(50);
        pets: Association to many Pets_Vet on pets.vet = $self;
}

entity Pets_Vet : cuid { // Tablai intermedia para asociación de muchos a muchos
    vet: Association to Vets;
    pet: Association to Pets;
}

@cds.autoexpose
entity Diagnoses {
    key id          : Integer;
        pet         : Association to Pets;
        description : String;
};

entity Owners : fullname {
    key id        : Integer;
        street    : String(25);
        telephone : String(15);
        email     : String(40);
        pet       : Association to Pets;
};
