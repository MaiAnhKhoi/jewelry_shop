-- =========================
-- 1. Bảng người dùng và quyền
-- =========================
CREATE TABLE Roles (
    RoleID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) CHARACTER SET utf8mb4,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Phone VARCHAR(20),
    Avatar VARCHAR(255),
    RoleID INT NOT NULL DEFAULT 2,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID),
    INDEX (Email),
    INDEX (Phone)
);

CREATE TABLE Addresses (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    ReceiverName VARCHAR(100) CHARACTER SET utf8mb4,
    Phone VARCHAR(20),
    FullAddress VARCHAR(255) CHARACTER SET utf8mb4,
    IsDefault BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    INDEX (UserID)
);

-- =========================
-- 2. Bảng sản phẩm và danh mục
-- =========================
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) CHARACTER SET utf8mb4 UNIQUE,
    Description TEXT CHARACTER SET utf8mb4
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryID INT,
    Name VARCHAR(100) CHARACTER SET utf8mb4,
    Description TEXT CHARACTER SET utf8mb4,
    MainImage VARCHAR(255),
    IsActive BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    INDEX (CategoryID),
    INDEX (Name)
);

CREATE TABLE ProductVariants (
    VariantID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    Color VARCHAR(50) CHARACTER SET utf8mb4,
    Size VARCHAR(50) CHARACTER SET utf8mb4,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT DEFAULT 0,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    INDEX (ProductID)
);

CREATE TABLE ProductImages (
    ImageID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    ImageURL VARCHAR(255),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    INDEX (ProductID)
);

-- =========================
-- 3. Bảng giỏ hàng và đơn hàng
-- =========================
CREATE TABLE Carts (
    CartID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT UNIQUE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    INDEX (UserID)
);

CREATE TABLE CartItems (
    CartItemID INT AUTO_INCREMENT PRIMARY KEY,
    CartID INT NOT NULL,
    VariantID INT NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (CartID) REFERENCES Carts(CartID),
    FOREIGN KEY (VariantID) REFERENCES ProductVariants(VariantID),
    UNIQUE (CartID, VariantID),
    INDEX (CartID),
    INDEX (VariantID)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    TotalAmount DECIMAL(12,2) NOT NULL,
    VoucherCode VARCHAR(50),
    Status VARCHAR(30) DEFAULT 'Pending',
    Note TEXT CHARACTER SET utf8mb4,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    INDEX (UserID),
    INDEX (Status)
);

CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    VariantID INT NOT NULL,
    ProductName VARCHAR(100) CHARACTER SET utf8mb4,
    VariantName VARCHAR(100) CHARACTER SET utf8mb4,
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (VariantID) REFERENCES ProductVariants(VariantID),
    INDEX (OrderID),
    INDEX (VariantID)
);

-- =========================
-- 4. Đánh giá, yêu thích, phản hồi
-- =========================
CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT CHARACTER SET utf8mb4,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    UNIQUE (UserID, ProductID),
    INDEX (UserID),
    INDEX (ProductID)
);

CREATE TABLE Favorites (
    FavoriteID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    UNIQUE (UserID, ProductID),
    INDEX (UserID),
    INDEX (ProductID)
);

CREATE TABLE Feedbacks (
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Content TEXT CHARACTER SET utf8mb4,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    INDEX (UserID)
);

CREATE TABLE Contacts (
    ContactID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Subject VARCHAR(100),
    Message TEXT CHARACTER SET utf8mb4,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    INDEX (UserID)
);

-- =========================
-- 5. Mã giảm giá
-- =========================
CREATE TABLE Vouchers (
    Code VARCHAR(50) PRIMARY KEY,
    Description TEXT CHARACTER SET utf8mb4,
    Discount DECIMAL(10,2),
    ExpiryDate DATE
);

CREATE TABLE VoucherUsage (
    UsageID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    OrderID INT NOT NULL,
    VoucherCode VARCHAR(50) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (VoucherCode) REFERENCES Vouchers(Code),
    INDEX (UserID),
    INDEX (OrderID)
);

-- =========================
-- 6. Nhập hàng và kho
-- =========================
CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) CHARACTER SET utf8mb4 UNIQUE,
    ContactInfo TEXT CHARACTER SET utf8mb4
);

CREATE TABLE ProductImports (
    ImportID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierID INT NOT NULL,
    ImportedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Note TEXT CHARACTER SET utf8mb4,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    INDEX (SupplierID)
);

CREATE TABLE StockHistory (
    StockID INT AUTO_INCREMENT PRIMARY KEY,
    VariantID INT NOT NULL,
    ImportID INT,
    Quantity INT NOT NULL,
    Type ENUM('import','order','return'),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (VariantID) REFERENCES ProductVariants(VariantID),
    FOREIGN KEY (ImportID) REFERENCES ProductImports(ImportID),
    INDEX (VariantID),
    INDEX (ImportID)
);

-- =========================
-- 7. Chat & AI
-- =========================
CREATE TABLE Conversations (
    ConversationID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    INDEX (UserID)
);

CREATE TABLE Messages (
    MessageID INT AUTO_INCREMENT PRIMARY KEY,
    ConversationID INT NOT NULL,
    Sender ENUM('User', 'Admin', 'AI'),
    SenderID INT,
    Content TEXT CHARACTER SET utf8mb4,
    SentAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ConversationID) REFERENCES Conversations(ConversationID),
    INDEX (ConversationID)
);

-- =========================
-- 8. Cấu hình và giao diện
-- =========================
CREATE TABLE SystemConfigs (
    ConfigKey VARCHAR(50) PRIMARY KEY,
    ConfigValue VARCHAR(255)
);

CREATE TABLE Sliders (
    SliderID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100) CHARACTER SET utf8mb4,
    ImageURL VARCHAR(255),
    LinkURL VARCHAR(255),
    DisplayOrder INT DEFAULT 0,
    IsActive BOOLEAN DEFAULT TRUE
);
