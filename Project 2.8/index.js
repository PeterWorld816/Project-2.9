const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const app = express();
const PORT = 3000;

// Middleware
app.use(bodyParser.json());
app.use(express.json()); // For parsing JSON requests


// MongoDB Connection
mongoose.connect('mongodb://localhost:27017/movies')
  .then(() => {
    console.log('MongoDB connected');
  })
  .catch(err => {
    console.error('MongoDB connection error:', err);
  });
// Movie Schema
const movieSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: { type: String, required: true },
  genre: {
    name: { type: String, required: true },
    description: { type: String, required: true }
  },
  director: {
    name: { type: String, required: true },
    bio: { type: String, required: true },
    birthYear: { type: Number, required: true },
    deathYear: { type: Number, default: null }
  },
  imageUrl: { type: String, required: true },
  featured: { type: Boolean, required: true }
});

// User Schema
const userSchema = new mongoose.Schema({
  username: { type: String, required: true },
  password: { type: String, required: true },
  email: { type: String, required: true },
  dateOfBirth: { type: Date, required: true },
  favorites: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Movie' }]
});

const Movie = mongoose.model('Movie', movieSchema);
const User = mongoose.model('User', userSchema);

// Routes

// 1. Return a list of ALL movies to the user
app.get('/movies', (req, res) => {
  Movie.find()
    .then(movies => res.json(movies))
    .catch(err => res.status(500).send('Error: ' + err));
});

// 2. Return data about a single movie by title
app.get('/movies/:title', (req, res) => {
  Movie.findOne({ title: req.params.title })
    .then(movie => {
      if (movie) {
        res.json(movie);
      } else {
        res.status(404).send('Movie not found');
      }
    })
    .catch(err => res.status(500).send('Error: ' + err));
});

// 3. Return data about a genre by name/title
app.get('/genres/:name', (req, res) => {
  Movie.findOne({ 'genre.name': req.params.name })
    .then(movie => {
      if (movie) {
        res.json(movie.genre);
      } else {
        res.status(404).send('Genre not found');
      }
    })
    .catch(err => res.status(500).send('Error: ' + err));
});

// 4. Return data about a director by name
app.get('/directors/:name', (req, res) => {
  Movie.findOne({ 'director.name': req.params.name })
    .then(movie => {
      if (movie) {
        res.json(movie.director);
      } else {
        res.status(404).send('Director not found');
      }
    })
    .catch(err => res.status(500).send('Error: ' + err));
});

// 5. Allow new users to register
app.post('/users/register', (req, res) => {
  const newUser = new User(req.body);
  newUser.save()
    .then(() => res.status(201).send('User registered successfully'))
    .catch(err => res.status(400).send('Error: ' + err));
});

// 6. Allow users to update their user info
app.put('/users/:id', (req, res) => {
  User.findByIdAndUpdate(req.params.id, req.body, { new: true })
    .then(user => {
      if (user) {
        res.json(user);
      } else {
        res.status(404).send('User not found');
      }
    })
    .catch(err => res.status(400).send('Error: ' + err));
});

// 7. Allow users to add a movie to their favorites
app.post('/users/:userId/favorites/:movieId', (req, res) => {
  const { userId, movieId } = req.params;

  User.findByIdAndUpdate(
    userId,
    { $addToSet: { favorites: movieId } }, // Ensures the movie is not added more than once
    { new: true } // Return the updated document
  )
    .populate('favorites') // Optionally populate movie details
    .then((updatedUser) => {
      if (!updatedUser) {
        return res.status(404).send('User not found');
      }
      res.json(updatedUser); // Respond with the updated user data
    })
    .catch((err) => {
      console.error(err);
      res.status(500).send('Error: ' + err);
    });
});

// 8. Allow users to remove a movie from their favorites
app.delete('/users/:id/favorites/:movieId', (req, res) => {
  User.findByIdAndUpdate(req.params.id, { $pull: { favorites: req.params.movieId } })
    .then(user => {
      if (user) {
        res.send('Movie removed from favorites');
      } else {
        res.status(404).send('User not found');
      }
    })
    .catch(err => res.status(400).send('Error: ' + err));
});

// 9. Allow existing users to deregister
app.delete('/users/:id', (req, res) => {
  User.findByIdAndDelete(req.params.id)
    .then(user => {
      if (user) {
        res.send('User deregistered successfully');
      } else {
        res.status(404).send('User not found');
      }
    })
    .catch(err => res.status(500).send('Error: ' + err));
});

// Start Server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
