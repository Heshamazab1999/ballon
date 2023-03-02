enum Endpoint {
  getHomeAds,
  getMainCategories,
  getProducts,
  subCategories,
  getAllDrinks,
  getBranchesAddresses,
  getRestaurantFees,
  getRestaurantMoreInfo,
  getDiscount,
  getCouponUsed,
  getBarcodes,
  getFavourite,
  getBarcodesUsed,
  setFavourite,
}

Map<Endpoint, String> endpoint = {
  Endpoint.getHomeAds: "ads",
  Endpoint.getMainCategories: "categories",
  Endpoint.subCategories: "subcategories",
  Endpoint.getProducts: "categories/products/",
  Endpoint.getAllDrinks: "drinks",
  Endpoint.getBranchesAddresses: "branches",
  Endpoint.getRestaurantFees: "accounts",
  Endpoint.getFavourite: "getfavourite/",
  Endpoint.getRestaurantMoreInfo: "socials",
  Endpoint.getDiscount: "coupons/discount",
  Endpoint.getCouponUsed: 'coupons/used',
  Endpoint.getBarcodes: 'barcodes/',
  Endpoint.getBarcodesUsed: 'usedbarcode/create',
  Endpoint.setFavourite: 'favourite',
};

const String moreInfo = "categories";
