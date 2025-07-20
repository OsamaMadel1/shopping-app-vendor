String baseUrl = "http://multi-vendor-api.runasp.net/multi-vendor-api/";

/// account
const String signUp = "Account/user/register";
const String login = "Account/user/login";

/// managment Products
const String addProduct = "Product";
const String getAllProducts = "Product";
String getProductById(String id) => "Product/$id";
String deleteProduct(String id) => "Product/$id";

/// Categroies
const String addCategory = "Category";
const String getCategoyries = "Category";
String getCategoyById(String id) => "Category/$id";
String updateCategoy(String id) => "Category/$id";
String deleteCategoy(String id) => "Category/$id";

/// orders
String getAllOrders = "Order";
String getOrderById(String id) => "Order/$id";
