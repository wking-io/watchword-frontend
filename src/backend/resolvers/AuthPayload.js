function user({ user: { id } }, _, context, info) {
  return context.db.query.user({ where: { id } }, info);
}

module.exports = { user };
