const jwt = require('jsonwebtoken');
const passport = require('passport');
const bcrypt = require('bcrypt');
const Models = require('./models.js');

const { User } = Models;

const jwtSecret = 'your_jwt_secret'; // Use a secure secret

module.exports = (app) => {
  // POST login endpoint
  app.post('/login', (req, res) => {
    const { username, password } = req.body;

    // Find the user by username
    User.findOne({ username: username }, (err, user) => {
      if (err) {
        return res.status(500).json({ message: 'Error on the server.' });
      }

      if (!user) {
        return res.status(404).json({ message: 'User not found.' });
      }

      // Check if the password matches
      const passwordIsValid = bcrypt.compareSync(password, user.password);
      if (!passwordIsValid) {
        return res.status(401).json({ message: 'Invalid password.' });
      }

      // Create the JWT token if the password is valid
      const token = jwt.sign({ id: user._id }, jwtSecret, { expiresIn: '1h' });

      // Send the token back to the client
      res.status(200).json({ token: token });
    });
  });
};
