// Switch to the correct database
use('my_app');


// Creating sql tables, sample for testing

const product_table = 'products';
const user_table = 'users';

db.createCollection(user_table);
db.createCollection(product_table)


// Inserting data into users and products collections
const users = [
  { user_id: 1, name: "Alice", email: "alice@example.com", age: 28 },
  { user_id: 2, name: "Bob", email: "bob@example.com", age: 34 },
  { user_id: 3, name: "Charlie", email: "charlie@example.com", age: 25 },
  { user_id: 4, name: "David", email: "david@example.com", age: 30 },
  { user_id: 5, name: "Eve", email: "eve@example.com", age: 22 }
];

const products = [
  { product_id: 101, name: "Laptop", category: "Electronics", price: 1200 },
  { product_id: 102, name: "Smartphone", category: "Electronics", price: 800 },
  { product_id: 103, name: "Headphones", category: "Accessories", price: 150 },
  { product_id: 104, name: "Book", category: "Stationery", price: 20 },
  { product_id: 105, name: "Backpack", category: "Bags", price: 60 }
];



db.users.insertMany(users);
db.products.insertMany(products);

// Inserting data into reviews collection
db.reviews.insertMany([
  {
    product_id: 101, // Laptop
    reviews: [
      {
        user_id: 1, // Alice
        message: "The laptop is fast and reliable!"
      },
      {
        user_id: 2, // Bob
        message: "Great performance, but a bit pricey."
      }
    ]
  },
  {
    product_id: 102, // Smartphone
    reviews: [
      {
        user_id: 3, // Charlie
        message: "Amazing camera quality!"
      },
      {
        user_id: 4, // David
        message: "Battery life could be better."
      }
    ]
  },
  {
    product_id: 103, // Headphones
    reviews: [
      {
        user_id: 5, // Eve
        message: "Very comfortable and great sound quality."
      }
    ]
  }
]);

// Inserting data into cart collection
db.cart.insertMany([
  {
    user_id: 1, // Alice
    items: [
      {
        product_id: 101, // Laptop
        quantity: 1,
        created_at: new Date()
      },
      {
        product_id: 103, // Headphones
        quantity: 2,
        created_at: new Date()
      }
    ]
  },
  {
    user_id: 2, // Bob
    items: [
      {
        product_id: 102, // Smartphone
        quantity: 1,
        created_at: new Date()
      }
    ]
  },
  {
    user_id: 3, // Charlie
    items: [
      {
        product_id: 104, // Book
        quantity: 3,
        created_at: new Date()
      }
    ]
  }
]);

// Inserting data into user_activity collection
db.user_activity.insertMany([
  {
    user_id: 1, // Alice
    logs: [
      {
        date: new Date(),
        activity: "Viewed product with ID 101 (Laptop)"
      },
      {
        date: new Date(),
        activity: "Added product with ID 103 (Headphones) to cart"
      }
    ]
  },
  {
    user_id: 2, // Bob
    logs: [
      {
        date: new Date(),
        activity: "Logged into the app"
      },
      {
        date: new Date(),
        activity: "Searched for 'smartphones'"
      }
    ]
  },
  {
    user_id: 3, // Charlie
    logs: [
      {
        date: new Date(),
        activity: "Viewed product with ID 104 (Book)"
      }
    ]
  }
]);

// Inserting data into wishlist collection
db.wishlist.insertMany([
  {
    user_id: 1, // Alice
    items: [
      {
        product_id: 102, // Smartphone
        added_at: new Date()
      },
      {
        product_id: 105, // Backpack
        added_at: new Date()
      }
    ]
  },
  {
    user_id: 2, // Bob
    items: [
      {
        product_id: 101, // Laptop
        added_at: new Date()
      }
    ]
  },
  {
    user_id: 3, // Charlie
    items: [
      {
        product_id: 103, // Headphones
        added_at: new Date()
      }
    ]
  }
]);