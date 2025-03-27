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
    product_id: 101,
    reviews: [
      {
        user_id: 1,
        message: "The laptop is fast and reliable!"
      },
      {
        user_id: 2,
        message: "Great performance, but a bit pricey."
      }
    ]
  },
  {
    product_id: 102,
    reviews: [
      {
        user_id: 3,
        message: "Amazing camera quality!"
      },
      {
        user_id: 4,
        message: "Battery life could be better."
      }
    ]
  },
  {
    product_id: 103,
    reviews: [
      {
        user_id: 5,
        message: "Very comfortable and great sound quality."
      }
    ]
  }
]);

// Inserting data into cart collection
db.cart.insertMany([
  {
    user_id: 1,
    items: [
      {
        product_id: 101,
        quantity: 1,
        created_at: new Date()
      },
      {
        product_id: 103,
        quantity: 2,
        created_at: new Date()
      }
    ]
  },
  {
    user_id: 2,
    items: [
      {
        product_id: 102,
        quantity: 1,
        created_at: new Date()
      }
    ]
  },
  {
    user_id: 3,
    items: [
      {
        product_id: 104,
        quantity: 3,
        created_at: new Date()
      }
    ]
  }
]);

// Inserting data into user_activity collection
db.user_activity.insertMany([
  {
    user_id: 1,
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
    user_id: 2,
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
    user_id: 3,
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
    user_id: 1,
    items: [
      {
        product_id: 102,
        added_at: new Date()
      },
      {
        product_id: 105,
        added_at: new Date()
      }
    ]
  },
  {
    user_id: 2,
    items: [
      {
        product_id: 101,
        added_at: new Date()
      }
    ]
  },
  {
    user_id: 3,
    items: [
      {
        product_id: 103,
        added_at: new Date()
      }
    ]
  }
]);