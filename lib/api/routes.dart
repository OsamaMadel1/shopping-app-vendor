String baseUrl = "http://multi-vendor-api.runasp.net/multi-vendor-api/";

/// account
const String signUp = "Account/user/register";
const String login = "Account/user/login";

/// managment Products
const String addProduct = "Product";
const String getAllProducts = "Product";
String updateProduct(String id) => "Product/$id";
String getProductById(String id) => "Product/$id";
String deleteProduct(String id) => "Product/$id";

/// Categroies
const String addCategory = "Category";
const String getCategoyries = "Category";
String getCategoyById(String id) => "Category/$id";
String updateCategoy(String id) => "Category/$id";
String deleteCategoy(String id) => "Category/$id";

/// orders
String getAllOrdersByShopId(String shopId) => "Order/$shopId";
String getOrderById(String id) => "Order/$id";

/// offers
String getAllOffresByShopId(String shopId) => "Offer/$shopId";
String getOfferById(String id) => "Offer/$id";
const addOffer = "Offer";
String updateOffer(String id) => "Offer/$id";
String deleteOffer(String id) => "Offer/$id";

/// comments
String getCommentsByProductId(String productId) => "Rate/comment/$productId";
