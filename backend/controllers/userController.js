const User = require('../models/userModel.js');

// Create new user
exports.createUser = async (req, res) => {
  const newUser = await User.create(req.body);
  res.status(201).json({
    status: 'success',
    message: `Created user: ${newUser['username']}.`,
  });
};

// Login user
exports.loginUser = async (req, res) => {
  const user = await User.findOne({ email: req.body.email }).select('+password +salt');
  if (!user || !user.validatePassword(req.body.password, user.password, user.salt)) {
    res.status(401).json({ status: 'fail', message: 'Invalid credentials.' });
  } else {
    res.status(200).json({
      status: 'message',
      message: 'Logged in successfully.',
      user: { username: user.username, email: user.email },
    });
  }
};
