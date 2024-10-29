  const jwt = require('jsonwebtoken');
  
  const express = require('express');
  const mongoose = require('mongoose');
  const bodyParser = require('body-parser');
  const Models = require('./models.js');
  const passport = require('passport');
  require('./passport');
  const bcrypt = require('bcrypt');
  const { check, validationResult } = require('express-validator');
  const { Movie, User } = Models;

  const app = express();
  const PORT = 3000;

  // Middleware
  app.use(bodyParser.json());
  app.use(express.json()); // For parsing JSON requests
  const cors = require('cors');
  app.use(cors());
  let auth = require('./auth')(app);

  // Initialize Passport
  app.use(passport.initialize()); // Initialize passport middleware

  // MongoDB Connection
  mongoose.connect('mongodb://localhost:27017/movies')
    .then(() => {
      console.log('MongoDB connected');
    })
    .catch(err => {
      console.error('MongoDB connection error:', err);
    });

  // 5. Allow new users to register
  app.post('/users/register', (req, res) => {
    const { username, password, email, dateOfBirth } = req.body;

    User.findOne({ email })
      .then(existingUser => {
        if (existingUser) {
          return res.status(400).send('Error: Email already in use');
        }

        const newUser = new User(req.body);
        newUser.password = bcrypt.hashSync(password, 10); // Hash password before saving
        return newUser.save();
      })
      .then(() => res.status(201).send('User registered successfully'))
      .catch(err => res.status(400).send('Error: ' + err));
  });


  // 1. Return a list of ALL movies to the user (JWT protected)
  app.get('/movies', passport.authenticate('jwt', { session: false }), (req, res) => {
    Movie.find()
      .then(movies => res.json(movies))
      .catch(err => res.status(500).send('Error: ' + err));
  });

  // 2. Return data about a single movie by title (JWT protected)
  app.get('/movies/:title', passport.authenticate('jwt', { session: false }), (req, res) => {
    Movie.findOne({ title: req.params.title })
      .then(movie => {
        if (movie) {
          return res.json(movie);
        } else {
          return res.status(404).send('Movie not found');
        }
      })
      .catch(err => res.status(500).send('Error: ' + err));
  });

  // 3. Return data about a genre by name/title (JWT protected)
  app.get('/genres/:name', passport.authenticate('jwt', { session: false }), (req, res) => {
    Movie.findOne({ 'genre.name': req.params.name })
      .then(movie => {
        if (movie) {
          return res.json(movie.genre);
        } else {
          return res.status(404).send('Genre not found');
        }
      })
      .catch(err => res.status(500).send('Error: ' + err));
  });

  // 4. Return data about a director by name (JWT protected)
  app.get('/directors/:name', passport.authenticate('jwt', { session: false }), (req, res) => {
    Movie.findOne({ 'director.name': req.params.name })
      .then(movie => {
        if (movie) {
          return res.json(movie.director);
        } else {
          return res.status(404).send('Director not found');
        }
      })
      .catch(err => res.status(500).send('Error: ' + err));
  });

  // 6. Allow users to update their user info (JWT protected)
  app.put('/users/:id', passport.authenticate('jwt', { session: false }), (req, res) => {
    User.findByIdAndUpdate(req.params.id, req.body, { new: true })
      .then(user => {
        if (user) {
          return res.json(user);
        } else {
          return res.status(404).send('User not found');
        }
      })
      .catch(err => res.status(400).send('Error: ' + err));
  });

  // 7. Allow users to add a movie to their favorites (JWT protected)
  app.post('/users/:userId/favorites/:movieId', passport.authenticate('jwt', { session: false }), (req, res) => {
    const { userId, movieId } = req.params;

    User.findByIdAndUpdate(
      userId,
      { $addToSet: { favorites: movieId } }, // Prevent duplicate entries
      { new: true }
    )
      .populate('favorites')
      .then(updatedUser => {
        if (!updatedUser) {
          return res.status(404).send('User not found');
        }
        return res.json('Movie added to favorites');
      })
      .catch(err => res.status(500).send('Error: ' + err));
  });

  // 8. Allow users to remove a movie from their favorites (JWT protected)
  app.delete('/users/:id/favorites/:movieId', passport.authenticate('jwt', { session: false }), (req, res) => {
    User.findByIdAndUpdate(req.params.id, { $pull: { favorites: req.params.movieId } })
      .then(user => {
        if (user) {
          return res.send('Movie removed from favorites');
        } else {
          return res.status(404).send('User not found');
        }
      })
      .catch(err => res.status(400).send('Error: ' + err));
  });

  // 9. Allow existing users to deregister (JWT protected)
  app.delete('/users/:id', passport.authenticate('jwt', { session: false }), (req, res) => {
    User.findByIdAndDelete(req.params.id)
      .then(user => {
        if (user) {
          return res.send('User deregistered successfully');
        } else {
          return res.status(404).send('User not found');
        }
      })
      .catch(err => res.status(500).send('Error: ' + err));
  });

  app.post('/users', async (req, res) => {
    let hashedPassword = Users.hashPassword(req.body.Password);
    await Users.findOne({ Username: req.body.Username }) // Search to see if a user with the requested username already exists
      .then((user) => {
        if (user) {
        //If the user is found, send a response that it already exists
          return res.status(400).send(req.body.Username + ' already exists');
        } else {
          Users
            .create({
              Username: req.body.Username,
              Password: hashedPassword,
              Email: req.body.Email,
              Birthday: req.body.Birthday
            })
            .then((user) => { res.status(201).json(user) })
            .catch((error) => {
              console.error(error);
              res.status(500).send('Error: ' + error);
            });
        }
      })
      .catch((error) => {
        console.error(error);
        res.status(500).send('Error: ' + error);
      });
  });

  // Start Server
  const port = process.env.PORT || 8080;
  app.listen(port, '0.0.0.0',() => {
   console.log('Listening on Port ' + port);
  });
