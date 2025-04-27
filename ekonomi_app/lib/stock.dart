class   Stock {
  int stock_id;
  String stock_name;
  String? stock_tanitim;
  String? stock_adet;
  String? stock_XXl;
  String? stock_Xl;
  String? stock_L;
  String? stock_M;
  String? stock_S;

  Stock({
    required this.stock_id,
    required this.stock_name,
    this.stock_tanitim,
    this.stock_adet,
    this.stock_XXl,
    this.stock_Xl,
    this.stock_L,
    this.stock_M,
    this.stock_S,
  });
}
