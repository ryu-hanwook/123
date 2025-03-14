import 'dart:io';

void main() {
  ShoppingMall mall = ShoppingMall([
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ]);

  print("\n1: 상품 목록 보기");
  print("2: 장바구니에 추가");
  print("3: 총 가격 보기");
  print("4: 종료");

  processInput(mall);
}

void processInput(ShoppingMall mall) {
  while (true) {
    stdout.write("선택: ");
    String? choice = stdin.readLineSync()?.trim();
    switch (choice) {
      case '1':
        mall.showProducts();
        break;
      case '2':
        mall.addToCart();
        break;
      case '3':
        mall.showTotal();
        break;
      case '4':
        print("이용해 주셔서 감사합니다 ~ 안녕히 가세요!");
        return;
      default:
        print("지원하지 않는 기능입니다! 다시 시도해 주세요.");
    }
  }
}

class Product {
  final String name;
  final int price;
  Product(this.name, this.price);
}

class ShoppingMall {
  final List<Product> products;
  final Map<String?, int> cart = {};
  int totalPrice = 0;

  ShoppingMall(this.products);

  void showProducts() {
    print("\n판매 상품 목록:");
    for (var product in products) {
      print("${product.name} / ${product.price}원");
    }
  }

  void addToCart() {
    stdout.write("상품 이름을 입력하세요: ");
    String? productName = stdin.readLineSync()?.trim();

    stdout.write("상품 개수를 입력하세요: ");
    String? quantityInput = stdin.readLineSync()?.trim();

    int? quantity = int.tryParse(quantityInput ?? "");
    if (quantity == null || quantity <= 0) {
      print("0개보다 많은 개수의 상품만 담을 수 있어요!");
      return;
    }

    var product = products.firstWhere(
      (p) => p.name == productName,
      orElse: () => Product('', 0),
    );

    if (product.name.isEmpty) {
      print("입력값이 올바르지 않아요!");
      return;
    }

    cart[productName] = (cart[productName] ?? 0) + quantity;
    totalPrice += product.price * quantity;
    print("장바구니에 상품이 담겼어요!");
  }

  void showTotal() {
    print("\n장바구니에 ${totalPrice}원 어치를 담으셨네요!");
  }
}
