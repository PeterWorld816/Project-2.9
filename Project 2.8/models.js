const mongoose = require('mongoose');

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

module.exports.Movie = Movie;
module.exports.User = User;