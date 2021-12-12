const express = require('express');

const userRouter = require('./routes/userRoutes.js');
const materialRouter = require('./routes/materialRoutes.js');

// Create express app
const app = express();

// Body-parser
app.use(express.json({ limit: '10kb' }));

// Routers
app.use('/api/v1/users', userRouter);
app.use('/api/v1/materials', materialRouter);

// Unhandled routes
app.all('*', (req, res) => {
  res.status(404).json({ status: 'fail', message: `${req.url} not found.` });
});

module.exports = app;
