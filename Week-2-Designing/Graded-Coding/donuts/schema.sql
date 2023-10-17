CREATE TABLE "Ingredients" (
    "id" INTEGER,
    "name" TEXT,
    "price" NUMERIC,
    PRIMARY KEY("id")
);
CREATE TABLE "Donuts" (
    "id" INTEGER,
    "name" TEXT,
    "is_gluten_free" TEXT NOT NULL CHECK("is_gluten_free" IN('Yes', 'No')),
    "price" NUMERIC,
    PRIMARY KEY("id")
);
CREATE TABLE "Orders" (
    "id" INTEGER,
    "donuts" TEXT,
    "customer" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("donuts") REFERENCES "Donuts"("name"),
    FOREIGN KEY("customer") REFERENCES "Customer"("id")
);
CREATE TABLE "Customer" (
    "id" INTEGER,
    "first_name" TEXT,
    "last_name" TEXT,
    "orders" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("orders") REFERENCES "Orders"("id")
);