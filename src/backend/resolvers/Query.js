function games(_, args, context, info) {
  return context.db.query.games({}, info);
}

function words(_, args, context, info) {
  return context.db.query.words({}, info);
}

module.exports = {
  games,
  words,
};
