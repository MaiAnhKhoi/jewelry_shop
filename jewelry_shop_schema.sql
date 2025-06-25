-- =========================
-- 1. Bảng người dùng và quyền
-- =========================
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Phone VARCHAR(20),
    Avatar VARCHAR(255),
    RoleID INT,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID) ON DELETE SET NULL
);

CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    ReceiverName VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    Phone VARCHAR(20),
    FullAddress VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IsDefault BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- =========================
-- 2. Bảng sản phẩm và danh mục
-- =========================
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    Description TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryID INT,
    Name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    Description TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    MainImage VARCHAR(255),
    IsActive BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE SET NULL
);

CREATE TABLE ProductVariants (
    VariantID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    Color VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    Size VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT DEFAULT 0,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

CREATE TABLE ProductImages (
    ImageID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    ImageURL VARCHAR(255),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- =========================
-- 3. Bảng giỏ hàng và đơn hàng
-- =========================
CREATE TABLE Carts (
    CartID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT UNIQUE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE CartItems (
    CartItemID INT PRIMARY KEY AUTO_INCREMENT,
    CartID INT,
    VariantID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (CartID) REFERENCES Carts(CartID) ON DELETE CASCADE,
    FOREIGN KEY (VariantID) REFERENCES ProductVariants(VariantID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    AddressID INT,
    TotalAmount DECIMAL(12,2) NOT NULL,
    VoucherCode VARCHAR(50),
    Status VARCHAR(30) NOT NULL,
    Note TEXT,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE SET NULL
    FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID) ON DELETE SET NULL
);

CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    VariantID INT,
    ProductName VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    VariantName VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (VariantID) REFERENCES ProductVariants(VariantID)
);

-- =========================
-- 4. Bảng đánh giá, yêu thích, phản hồi
-- =========================
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    ProductID INT,
    Rating INT NOT NULL,
    Comment TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

CREATE TABLE Favorites (
    FavoriteID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    ProductID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

CREATE TABLE CommentLikes (
    LikeID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    ReviewID INT,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ReviewID) REFERENCES Reviews(ReviewID) ON DELETE CASCADE
);



CREATE TABLE Contacts (
    ContactID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Message TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- =========================
-- 5. Bảng mã giảm giá và sử dụng
-- =========================
CREATE TABLE Vouchers (
    Code VARCHAR(50) PRIMARY KEY,
    Description TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    Discount DECIMAL(10,2) NOT NULL,
    ExpiryDate DATE NOT NULL
);

CREATE TABLE VoucherUsage (
    UsageID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    OrderID INT,
    VoucherCode VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (VoucherCode) REFERENCES Vouchers(Code) ON DELETE CASCADE
);

-- =========================
-- 6. Bảng quản lý nhập hàng và kho
-- =========================
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    ContactInfo TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
);

CREATE TABLE ProductImports (
    ImportID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierID INT,
    ImportedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    Note TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) ON DELETE SET NULL
);

CREATE TABLE StockHistory (
    StockID INT PRIMARY KEY AUTO_INCREMENT,
    VariantID INT,
    ImportID INT,
    Quantity INT NOT NULL,
    Type ENUM('import','order','return'),
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (VariantID) REFERENCES ProductVariants(VariantID) ON DELETE CASCADE,
    FOREIGN KEY (ImportID) REFERENCES ProductImports(ImportID) ON DELETE SET NULL
);

-- =========================
-- 7. Bảng chat và AI
-- =========================
CREATE TABLE Conversations (
    ConversationID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Messages (
    MessageID INT PRIMARY KEY AUTO_INCREMENT,
    ConversationID INT,
    Sender ENUM('User', 'Admin', 'AI'),
    SenderID INT NULL,
    Content TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    SentAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ConversationID) REFERENCES Conversations(ConversationID) ON DELETE CASCADE
);

-- =========================
-- 8. Hệ thống cấu hình & slider
-- =========================
CREATE TABLE SystemConfigs (
    ConfigKey VARCHAR(50) PRIMARY KEY,
    ConfigValue VARCHAR(255)
);

CREATE TABLE Sliders (
    SliderID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    ImageURL VARCHAR(255),
    LinkURL VARCHAR(255),
    DisplayOrder INT DEFAULT 0,
    IsActive BOOLEAN DEFAULT TRUE
);
