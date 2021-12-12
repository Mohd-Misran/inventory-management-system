const dotenv = require('dotenv');
const mongoose = require('mongoose');
const app = require('./app.js');

// Load config
dotenv.config({ path: './config.env' });

// Connect to DB
mongoose.connect(process.env.DATABASE).then(() => {
  console.log('DB connection successful.');
});

// Create server
const port = 3000;
app.listen(port, () => {
  console.log(`App running on port ${port}`);
});
