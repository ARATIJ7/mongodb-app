1. Setup Node.js Environment
Install Node.js:

Visit nodejs.org.
Download the latest stable version of Node.js suitable for your operating system (Windows, macOS, or Linux).
Follow the installation instructions for your OS to install Node.js and npm (Node Package Manager).
Initialize a new Node.js project:

Open your terminal (Command Prompt, PowerShell, or any terminal application).
Navigate to your project directory using the cd command. For example:
bash
Copy code
cd path/to/your/project
Run the following command to initialize a new Node.js project, which creates a package.json file in your project directory:
bash
Copy code
npm init -y
The package.json file contains metadata about your project and its dependencies.

2. Install Required Packages
Install Express and Mongoose:

Run the following command in your terminal to install Express (a web application framework for Node.js) and Mongoose (an ODM for MongoDB):
bash
Copy code
npm install express mongoose
This command adds Express and Mongoose to your project and updates the package.json and package-lock.json files.

3. Create a Basic Express Server
In your project directory, create a new file named server.js.
Open server.js in your code editor and add the following code:
javascript
Copy code
const express = require('express');
const mongoose = require('mongoose');
const app = express();
const port = process.env.PORT || 3000;

// Connect to MongoDB
mongoose.connect('YOUR_MONGODB_CONNECTION_STRING', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Middleware to parse JSON requests
app.use(express.json());

// Basic route for testing
app.get('/', (req, res) => {
  res.send('Jewelry App Backend');
});

// Start the server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
Explanation:

express and mongoose are imported.
An Express app is created.
The app connects to MongoDB using Mongoose.
The app is configured to parse JSON requests with express.json().
A basic route is set up to respond with a message when accessed.
The app listens on a specified port (default is 3000) and logs a message when the server starts.
4. Define Models and Routes
Create Models
In your project directory, create a new directory named models.
Inside the models directory, create a file named Item.js.
Open Item.js in your code editor and add the following code:
javascript
Copy code
const mongoose = require('mongoose');

const itemSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  description: {
    type: String,
  },
  price: {
    type: Number,
    required: true,
  },
  stock: {
    type: Number,
    required: true,
  },
});

const Item = mongoose.model('Item', itemSchema);

module.exports = Item;
Explanation:

mongoose is imported.
A Mongoose schema is defined for the items in your jewelry store with fields for name, description, price, and stock.
A Mongoose model named Item is created using the schema.
The model is exported for use in other parts of the application.
Create Routes
In your project directory, create a new directory named routes.
Inside the routes directory, create a file named items.js.
Open items.js in your code editor and add the following code:
javascript
Copy code
const express = require('express');
const router = express.Router();
const Item = require('../models/Item');

// Get all items
router.get('/', async (req, res) => {
  try {
    const items = await Item.find();
    res.json(items);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Create a new item
router.post('/', async (req, res) => {
  const item = new Item({
    name: req.body.name,
    description: req.body.description,
    price: req.body.price,
    stock: req.body.stock,
  });

  try {
    const newItem = await item.save();
    res.status(201).json(newItem);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

module.exports = router;
Explanation:

express and the Item model are imported.
An Express router is created.
A GET route is defined to fetch all items from the database.
A POST route is defined to create a new item in the database.
The router is exported for use in the main server file.
Integrate Routes with Express Server
Open server.js and modify it to use the new routes.
javascript
Copy code
const express = require('express');
const mongoose = require('mongoose');
const app = express();
const port = process.env.PORT || 3000;

// Import routes
const itemsRouter = require('./routes/items');

// Connect to MongoDB
mongoose.connect('YOUR_MONGODB_CONNECTION_STRING', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Middleware to parse JSON requests
app.use(express.json());

// Use routes
app.use('/api/items', itemsRouter);

// Basic route for testing
app.get('/', (req, res) => {
  res.send('Jewelry App Backend');
});

// Start the server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
Explanation:

The itemsRouter is imported from the routes/items file.
The app is configured to use the itemsRouter for any routes starting with /api/items.
Now you have a basic Express server set up with MongoDB, models for your items, and routes for handling HTTP requests. You can extend this setup by adding more models and routes as needed for your jewelry app.

