const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Define Movie Schema
const movieSchema = new Schema({
  title: { type: String, required: true },
  description: { type: String, required: true },
  director: { type: mongoose.Schema.Types.ObjectId, ref: 'Director' },
  genre: { type: mongoose.Schema.Types.ObjectId, ref: 'Genre' },
  imageUrl: { type: String },
  featured: { type: Boolean, default: false }
});

// Define User Schema
const userSchema = new Schema({
  username: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  birthday: { type: Date },
  favoriteMovies: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Movie' }]
});

// Create Models
const Movie = mongoose.model('Movie', movieSchema); // Define the Movie model
const User = mongoose.model('User', userSchema);    // Define the User model

// Export Models
module.exports = {
  Movie,
  User
};
