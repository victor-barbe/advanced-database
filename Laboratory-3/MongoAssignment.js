//1
db.users.count();

//2
db.movies.count();

//3
db.users.aggregate([
  { $match: { name: "Clifford Johnathan" } },
  { $project: { _id: 0, name: 1, occupation: 1 } },
]);

//4
db.users.count({ age: { $lte: 30, $gte: 18 } });

//5
db.users.count({
  $or: [{ occupation: "artist" }, { occupation: "scientist" }],
});

//6
db.users
  .find(
    { $and: [{ gender: "F" }, { occupation: "writer" }] },
    { _id: 0, name: 1 }
  )
  .sort({ age: -1 })
  .limit(10);

//7
db.users.aggregate({ $group: { _id: "$occupation" } });

//8
db.users.insertOne({
  name: "Victor Barbe",
  gender: "M",
  age: "21",
  occupation: "Student",
});

//9
db.users.deleteOne({ name: "Victor Barbe" });

//10
db.users.updateMany(
  { occupation: "programmer" },
  { $set: { occupation: "developper" } }
);

//11
db.movies.updateMany(
  { title: { $regex: "Cinderella" } },
  { $set: { genres: "Animation|Children's|Muscial" } }
);

//12
db.movies.count({ title: { $regex: "198" } });

//13
db.movies.count({ genres: { $regex: "Horror" } });

//14
db.movies.count({
  $and: [{ genres: { $regex: "Horror" } }, { genres: { $regex: "Romance" } }],
});

//15
db.users.count({ "movies.movieid": 1196 });

//16
db.users.count({
  $and: [
    { "movies.movieid": 1196 },
    { "movies.movieid": 260 },
    { "movies.movieid": 1210 },
  ],
});

//17
db.users.count({ movies: { $size: 48 } });

//18
db.users.updateMany({}, [{ $set: { num_ratings: { $size: "$movies" } } }]);

//19
db.users.count({ num_ratings: { $gte: 95 } });

//20
db.users.aggregate([
  { $match: { name: "Jayson Brad" } },
  { $unwind: "$movies" },
  { $project: { _id: 0, "movies.movieid": 1 } },
  { $sort: { "movies.timestamp": 1 } },
  { $limit: 3 },
]);

//21
db.movies.aggregate([
  { $match: { title: { $regex: "199" } } },
  { $group: { _id: 1, numberMovies: { $avg: "$movies.rating" } } },
  { $project: { _id: 1, numberMovies: 1, year: 1 } },
  { $sort: { year: 1 } },
]);

db.movies.aggregate([{ $match: { title: { $regex: "199" } } }, { $switch }]);

//22

db.users.aggregate([
  { $unwind: "$movies" },
  { $match: { "movies.movieid": 296 } },
  { $group: { _id: 0, averagePulpFictionRating: { $avg: "$movies.rating" } } },
]);

//23
db.users.aggregate([
  { $unwind: "$movies" },
  {
    $group: {
      _id: "$name",
      averageRating: { $avg: "$movies.rating" },
      maxRating: { $max: "$movies.rating" },
      minRating: { $min: "$movies.rating" },
    },
  },
  { $project: { _id: 1, averageRating: 1, maxRating: 1, minRating: 1 } },
  { $sort: { averageRating: 1 } },
]);

//23 sans project
db.users.aggregate([
  { $unwind: "$movies" },
  {
    $group: {
      _id: "$name",
      averageRating: { $avg: "$movies.rating" },
      maxRating: { $max: "$movies.rating" },
      minRating: { $min: "$movies.rating" },
    },
  },
  { $sort: { averageRating: 1 } },
]);

//24
db.users.aggregate([
  { $unwind: "$movies" },
  {
    $lookup: {
      from: "movies",
      localField: "gender",
      foreignField: "movies.movieid",
      as: "movieid",
    },
  },
  {
    $group: {
      _id: "$name",
      averageRating: { $avg: "$movies.rating" },
      maxRating: { $max: "$movies.rating" },
      minRating: { $min: "$movies.rating" },
    },
  },
  { $sort: { averageRating: 1 } },
]);
