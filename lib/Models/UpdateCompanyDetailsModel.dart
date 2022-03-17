class UpdateCompanyDeatailsModel {
  String? companyname;
  String? website;
  String? logo;

  UpdateCompanyDeatailsModel({this.companyname, this.website, this.logo});

  toMap() {
    return {
      "companyname": companyname,
      "website": website,
      "logo": logo,
    };
  }
}
