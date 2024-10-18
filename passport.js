const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const Models = require('./models.js');
const User = Models.User;

// Local Strategy for username and password login
passport.use(new LocalStrategy({ usernameField: 'username' }, (username, password, done) => {
  User.findOne({ username: username })
    .then(user => {
      if (!user) {
        return done(null, false, { message: 'User not found.' });
      }
      // Check password validity
      if (!bcrypt.compareSync(password, user.password)) {
        return done(null, false, { message: 'Invalid password.' });
      }
      return done(null, user);
    })
    .catch(err => done(err));
}));

// JWT Strategy for token-based authentication
const jwtOptions = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: 'your_jwt_secret'
};

passport.use(new JwtStrategy(jwtOptions, (jwt_payload, done) => {
  User.findById(jwt_payload.id)
    .then(user => {
      if (user) {
        return done(null, user);
      }
      return done(null, false);
    })
    .catch(err => done(err));
}));

module.exports = passport; // Correct export
