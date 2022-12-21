enum CatalogFmt { generalMammals, birds, bats }

enum SpecimenSex { male, female, unknown }

enum SpecimenAge { adult, subadult, juvenile, unknown }

SpecimenSex matchSpecimenSex(String? sex) {
  switch (sex) {
    case 'Male':
      return SpecimenSex.male;
    case 'Female':
      return SpecimenSex.female;
    default:
      return SpecimenSex.unknown;
  }
}

SpecimenAge matchSpecimenAge(String? age) {
  switch (age) {
    case 'Adult':
      return SpecimenAge.adult;
    case 'Subadult':
      return SpecimenAge.subadult;
    case 'Juvenile':
      return SpecimenAge.juvenile;
    default:
      return SpecimenAge.unknown;
  }
}

CatalogFmt matchTaxonGroup(String? taxonGroup) {
  switch (taxonGroup) {
    case 'Birds':
      return CatalogFmt.birds;
    case 'Mammals':
      return CatalogFmt.generalMammals;
    case 'Bats':
      return CatalogFmt.bats;
    default:
      return CatalogFmt.generalMammals;
  }
}
