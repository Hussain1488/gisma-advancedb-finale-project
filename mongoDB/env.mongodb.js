/* global use, db */
// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

const database = 'my_app';

const userActivitycollection = 'user_activity';
const reviews = 'reviews';
const cart = 'cart';
const wishlist = 'wishlist';



// The current database to use.
use(database);

// Defining the required format for user activiy collection.
db.createCollection(userActivitycollection, {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ['user_id', 'logs'],
      properties: {
        user_id: { bsonType: 'int' },
        logs: {
          bsonType: 'array',
          items: {
            bsonType: "object",
            required: ['date', 'activity'],
            properties: {
              date: { bsonType: 'date' },
              activity: { bsonType: 'string' }
            }
          }
        }
      }
    }
  }
});

// Defining the required format for review Collection.
db.createCollection(reviews, {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["product_id", "reviews"],
      properties: {
        product_id: { bsonType: "int" },
        reviews: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: ['user_id', 'message'],
            properties: {
              user_id: { bsonType: 'int' },
              message: { bsonType: 'string' }
            }
          }
        }
      }
    }
  }
});


// Defining the required format for cart collection.
db.createCollection(cart, {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["user_id", "items"],
      properties: {
        user_id: { bsonType: "int" },
        items: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: ["product_id", "quantity", "created_at"],
            properties: {
              product_id: { bsonType: "int" },
              quantity: { bsonType: "int" },
              created_at: { bsonType: "date" }
            }
          }
        }
      }
    }
  }
});

// Difining the reqiered format for user wish list collection.
db.createCollection('wishlist', {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["user_id", "items"],
      properties: {
        user_id: { bsonType: "int" },
        items: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: ["product_id", "added_at"],
            properties: {
              product_id: { bsonType: "int" },
              added_at: { bsonType: "date" }
            }
          }
        }
      }
    }
  }
});

// Difinitioin of collections indexes:

db.user_activity.createIndex({ user_id: 1 });

db.reviews.createIndex({ product_id: 1, "items.user_id": 1 });

db.cart.createIndex({ user_id: 1 });

db.wishlist.createIndex({ user_id: 1, 'items.product_id' :1 });


