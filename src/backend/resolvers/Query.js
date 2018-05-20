function games(_, args, context, info) {
  return context.db.query.games({}, info);
}

module.exports = {
  games,
};
